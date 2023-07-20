import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:firebase_authentication_app/models/user_model.dart';
import 'package:firebase_authentication_app/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit({required this.profileRepository})
      : super(ProfileState.initial());

  Future<void> fetchProfile({required String uid}) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await profileRepository.fetchProfile(uid: uid);
      emit(state.copyWith(status: ProfileStatus.loaded, user: user));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e));
    }
  }
}
