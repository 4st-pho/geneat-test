import 'package:firebase_authentication_app/blocs/login/login_cubit.dart';
import 'package:firebase_authentication_app/blocs/profile/profile_cubit.dart';
import 'package:firebase_authentication_app/blocs/signup/sign_up_cubit.dart';
import 'package:firebase_authentication_app/pages/home_page.dart';
import 'package:firebase_authentication_app/pages/login_page.dart';
import 'package:firebase_authentication_app/pages/profile_page.dart';
import 'package:firebase_authentication_app/pages/sign_up_page.dart';
import 'package:firebase_authentication_app/pages/splash_page.dart';
import 'package:firebase_authentication_app/repositories/auth_repository.dart';
import 'package:firebase_authentication_app/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  // static const String initRoute = "/";
  static const String initRoute = "/";
  static const String homeRoute = "/homeRoute";
  static const String splashRoute = "/splashRoute";
  static const String loginRoute = "/loginRoute";
  static const String signupRoute = "/signupRoute";
  static const String profileRoute = "/profileRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.initRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => Provider(
      //       create: (context) => MainBloc(),
      //       dispose: (_, bloc) => bloc.dispose(),
      //       child: const MainPage(),
      //     ),
      //   );
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                LoginCubit(authRespository: context.read<AuthRespository>()),
            child: const LoginPage(),
          ),
        );
      case Routes.signupRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                SignUpCubit(authRespository: context.read<AuthRespository>()),
            child: const SignUpPage(),
          ),
        );
      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProfileCubit(
                profileRepository: context.read<ProfileRepository>()),
            child: const ProfilePage(),
          ),
        );
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Route not found'),
        ),
        body: const Text('Route not found'),
      ),
    );
  }
}
