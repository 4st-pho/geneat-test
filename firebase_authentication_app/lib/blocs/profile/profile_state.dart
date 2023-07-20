part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user;
  final CustomError error;

  const ProfileState({
    required this.status,
    this.user,
    required this.error,
  });
  factory ProfileState.initial() {
    return const ProfileState(
        status: ProfileStatus.initial, error: CustomError());
  }

  @override
  List<Object?> get props => [status, user, error];

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    CustomError? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
