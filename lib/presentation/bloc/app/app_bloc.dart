// lib/presentation/bloc/app/app_bloc.dart
import 'dart:developer';

import 'package:constructor/core/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitialState()) {
    on<SplashEvent>(_onSplash);
    on<CheckAuthEvent>(_onCheckAuth);
    on<ChangeThemeEvent>(_onChangeTheme);

    _initializeTheme();
  }

  Future<void> _onSplash(
    SplashEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppSplashState());

    await Future.delayed(const Duration(milliseconds: 100));

    add(CheckAuthEvent());
  }

  Future<void> _onCheckAuth(
    CheckAuthEvent event,
    Emitter<AppState> emit,
  ) async {
    // StorageService.clear();
    final token = StorageService.read("token");

    inspect(token);

    if (token != null && token.isNotEmpty) {
      emit(AppAuthenticatedState());
    } else {
      emit(AppUnauthenticatedState());
    }
  }

  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<AppState> emit,
  ) async {
    bool isDarkMode = StorageService.read("isDarkMode") ?? false;

    if (event.isDarkMode != isDarkMode) {
      StorageService.write("isDarkMode", event.isDarkMode);
      emit(AppThemeChangedState(event.isDarkMode));
    }
  }

  Future<void> _initializeTheme() async {
    final isDarkMode = await StorageService.read("isDarkMode") ?? false;
    add(ChangeThemeEvent(isDarkMode));
  }
}
