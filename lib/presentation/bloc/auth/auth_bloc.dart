import 'package:constructor/core/constants/api_constants.dart';
import 'package:constructor/core/services/http_service.dart';
import 'package:constructor/core/services/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final res = await HttpService.post(ApiConsts.login, {
      "username": event.username,
      "password": event.password,
    });

    if (res['status'] == Result.success) {
      final userData = res['data'];

      StorageService.write("token", userData['token']);

      if (userData['user']['role']['name'] != "constructor") {
        emit(AuthErrorState("Siz konstruktor emassiz!"));
        return;
      }

      emit(AuthSuccessState(userData));
    } else {
      emit(AuthErrorState("Login yoki parol xato!"));
    }
  }
}
