import 'profile_model.dart';

class ProfileListState {
  final List<ProfileModel> profiles;
  final ProfileModel? selectedProfile;
  final int profileLimit;

  const ProfileListState({
    this.profiles = const [],
    this.selectedProfile,
    this.profileLimit = 0,
  });

  ProfileListState copyWith({
    List<ProfileModel>? profiles,
    ProfileModel? selectedProfile,
    int? profileLimit,
  }) {
    return ProfileListState(
      profiles: profiles ?? this.profiles,
      selectedProfile: selectedProfile ?? this.selectedProfile,
      profileLimit: profileLimit ?? this.profileLimit,
    );
  }
}
