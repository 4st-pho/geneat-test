import 'package:firebase_authentication_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_authentication_app/constants/app_strings.dart';
import 'package:firebase_authentication_app/constants/route_configure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Center(child: FlutterLogo(size: 150)),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.homePage),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.profileRoute);
          },
          icon: const Icon(Icons.account_box_rounded),
        ),
        IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLoggedOut());
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.loginRoute, (_) => false);
          },
          icon: const Icon(Icons.exit_to_app),
        )
      ],
    );
  }
}
