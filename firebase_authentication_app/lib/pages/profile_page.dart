import 'package:firebase_authentication_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_authentication_app/blocs/profile/profile_cubit.dart';
import 'package:firebase_authentication_app/constants/app_strings.dart';
import 'package:firebase_authentication_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    final uid = context.read<AuthBloc>().state.user?.uid ?? '';
    context.read<ProfileCubit>().fetchProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profile)),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial) {
            return const SizedBox();
          } else if (state.status == ProfileStatus.error) {
            Center(
              child: Text(
                  '${state.error.code}\n${state.error.message}\n${state.error.plugin}'),
            );
          } else if (state.status == ProfileStatus.loaded) {
            final user = state.user;
            return _buildProfile(user);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProfile(UserModel? user) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              user?.profileImage ?? '',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Id: ${user?.id}'),
                  ),
                  Text('Name: ${user?.name}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Email: ${user?.email}'),
                  ),
                  Text('Rank: ${user?.rank}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('point: ${user?.point}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
