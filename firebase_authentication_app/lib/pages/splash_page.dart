import 'package:firebase_authentication_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_authentication_app/constants/route_configure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        } else if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        }
      },
      builder: (context, state) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
