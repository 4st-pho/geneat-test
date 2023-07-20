part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoggedOut extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;
  const AuthLoggedIn({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class AuthSignedUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const AuthSignedUp({
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [name, email, password];
}

class AuthStateChanged extends AuthEvent {
  final fb_auth.User? user;
  const AuthStateChanged({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}
