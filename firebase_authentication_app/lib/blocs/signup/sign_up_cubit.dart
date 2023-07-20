import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:firebase_authentication_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRespository authRespository;
  SignUpCubit({required this.authRespository}) : super(SignUpState.initial());
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      await authRespository.signUp(
          name: name, email: email, password: password);
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }
}
