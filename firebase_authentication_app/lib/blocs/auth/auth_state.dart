part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fb_auth.User? user;
  const AuthState({
    required this.authStatus,
    required this.user,
  });

  @override
  List<Object?> get props => [authStatus, user];
  factory AuthState.unknown() {
    return const AuthState(authStatus: AuthStatus.unknown, user: null);
  }
  AuthState copyWith({AuthStatus? authStatus, fb_auth.User? user}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
