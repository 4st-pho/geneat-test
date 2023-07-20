import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:firebase_authentication_app/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRespository authRespository;
  LoginCubit({required this.authRespository}) : super(LoginState.initial());
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: LoginStatus.submitting));
    try {
      await authRespository.logIn(email: email, password: password);

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(loginStatus: LoginStatus.error, error: e));
    }
  }
}
