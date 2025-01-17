// lib/presentation/bloc/app/app_state.dart
part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitialState extends AppState {}

class AppSplashState extends AppState {}

class AppThemeChangedState extends AppState {
  final bool isDarkMode;

  const AppThemeChangedState(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

class AppAuthenticatedState extends AppState {}

class AppUnauthenticatedState extends AppState {}
