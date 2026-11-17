// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Profile)
const profileProvider = ProfileProvider._();

final class ProfileProvider
    extends $NotifierProvider<Profile, ProfileListState> {
  const ProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileHash();

  @$internal
  @override
  Profile create() => Profile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileListState>(value),
    );
  }
}

String _$profileHash() => r'3529e9f390649d17f8398973cf4d1d65374e34c2';

abstract class _$Profile extends $Notifier<ProfileListState> {
  ProfileListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProfileListState, ProfileListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileListState, ProfileListState>,
              ProfileListState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(profiles)
const profilesProvider = ProfilesProvider._();

final class ProfilesProvider
    extends
        $FunctionalProvider<
          List<ProfileModel>,
          List<ProfileModel>,
          List<ProfileModel>
        >
    with $Provider<List<ProfileModel>> {
  const ProfilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesHash();

  @$internal
  @override
  $ProviderElement<List<ProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ProfileModel> create(Ref ref) {
    return profiles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProfileModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProfileModel>>(value),
    );
  }
}

String _$profilesHash() => r'31c037b0795ed9bcf9d1760b7b58ec9168b52eaf';

@ProviderFor(limit)
const limitProvider = LimitProvider._();

final class LimitProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const LimitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'limitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$limitHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return limit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$limitHash() => r'5813404d0ead93946bee675cdd49e130670b2539';

@ProviderFor(selectedProfile)
const selectedProfileProvider = SelectedProfileProvider._();

final class SelectedProfileProvider
    extends $FunctionalProvider<ProfileModel?, ProfileModel?, ProfileModel?>
    with $Provider<ProfileModel?> {
  const SelectedProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedProfileHash();

  @$internal
  @override
  $ProviderElement<ProfileModel?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileModel? create(Ref ref) {
    return selectedProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileModel?>(value),
    );
  }
}

String _$selectedProfileHash() => r'bf3b066e3295355282a932ac8974e84ceda69660';

@ProviderFor(notes)
const notesProvider = NotesProvider._();

final class NotesProvider
    extends
        $FunctionalProvider<
          List<NotesModel>,
          List<NotesModel>,
          List<NotesModel>
        >
    with $Provider<List<NotesModel>> {
  const NotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesHash();

  @$internal
  @override
  $ProviderElement<List<NotesModel>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<NotesModel> create(Ref ref) {
    return notes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotesModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotesModel>>(value),
    );
  }
}

String _$notesHash() => r'df3cf37cdf657491aecef8afd7b9f0167a369491';
