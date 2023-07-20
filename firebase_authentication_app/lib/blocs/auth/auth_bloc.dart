import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRespository authRespository;
  late final StreamSubscription authSubscription;
  AuthBloc({required this.authRespository}) : super(AuthState.unknown()) {
    on<AuthStateChanged>(_updateAuthState);
    on<AuthLoggedOut>(_logout);

    authSubscription = authRespository.user.listen((user) {
      add(AuthStateChanged(user: user));
    });
  }

  Future<void> _updateAuthState(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(
        state.copyWith(authStatus: AuthStatus.authenticated, user: event.user),
      );
    } else {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  Future<void> _logout(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    return authRespository.logOut();
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
