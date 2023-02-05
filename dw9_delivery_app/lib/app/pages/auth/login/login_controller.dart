import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../repositories/auth/auth_repository.dart';
import './login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));

      final authModel = await _authRepository.login(email, password);

      final sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString('accessToken', authModel.accessToken);
      sharedPreferences.setString('refreshToken', authModel.refreshToken);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log('login e senha inválidos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            erroMessage: 'Login ou senha inválidos'),
      );
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.error, erroMessage: 'Erro ao realizar login'),
      );
    }
  }
}
