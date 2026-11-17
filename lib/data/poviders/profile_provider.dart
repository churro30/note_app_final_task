import 'package:notes_app_task3/data/local/notes_database.dart';
import 'package:notes_app_task3/data/models/notes_model.dart';
import 'package:notes_app_task3/data/models/profile_list_state.dart';
import 'package:notes_app_task3/data/models/profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
class Profile extends _$Profile {
  @override
  ProfileListState build() => const ProfileListState();

  Future<void> loadFromDatabase(int? selectedProfileId) async {
    final db = NotesDatabase.instance;
    final profiles = await db.readAllProfile();
    final notes = await db.readAllNotes();

    Map<int, List<NotesModel>> notesByProfile = {};
    for (final note in notes) {
      (notesByProfile[note.profileID] ??= <NotesModel>[]).add(note);
    }

    final loadedProfiles = profiles
        .map(
          (profile) =>
              profile.copyWith(notes: notesByProfile[profile.id] ?? const []),
        )
        .toList();

    ProfileModel? selected;
    for (final profile in loadedProfiles) {
      if (profile.id == selectedProfileId) {
        selected = profile;
        break;
      }
    }

    state = ProfileListState(
      profiles: loadedProfiles,
      profileLimit: loadedProfiles.length,
      selectedProfile: selected,
    );
  }

  // Profile Management Methods

  // Add a profile
  Future<void> addProfile(ProfileModel profile) async {
    if (state.profiles.any((existing) => existing.id == profile.id)) return;
    if (state.profileLimit >= 5) return;

    final savedProfile = await NotesDatabase.instance.createProfile(profile);
    state = state.copyWith(
      profiles: [...state.profiles, savedProfile],
      profileLimit: state.profileLimit + 1,
    );
  }

  // Remove a profile and its notes.
  Future<void> deleteProfile(ProfileModel profile) async {
    final id = profile.id;
    if (id == null) return;

    final index = state.profiles.indexWhere((p) => p.id == id);

    await NotesDatabase.instance.deleteProfile(id);
    final profiles = [...state.profiles]..removeAt(index);
    final selected = state.selectedProfile?.id == id
        ? (profiles.isEmpty ? null : profiles.first)
        : state.selectedProfile;

    state = ProfileListState(
      profiles: profiles,
      profileLimit: profiles.length,
      selectedProfile: selected,
    );
  }

  // Selected Profile
  Future<void> selectProfile(ProfileModel profile) async {
    final id = profile.id;
    if (id == null || !state.profiles.any((p) => p.id == id)) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_profile_id', id);

    state = state.copyWith(selectedProfile: profile);
  }

  Future<void> updateProfile(ProfileModel updatedProfile) async {
    final id = updatedProfile.id;

    final index = state.profiles.indexWhere((profile) => profile.id == id);

    await NotesDatabase.instance.updateProfile(updatedProfile);

    final profiles = [...state.profiles]..[index] = updatedProfile;

    state = state.copyWith(
      profiles: profiles,
      selectedProfile: state.selectedProfile?.id == id
          ? updatedProfile
          : state.selectedProfile,
    );
  }

  // Notes Management Methods
  Future<void> newNote(NotesModel note) async {
    final selected = state.selectedProfile;

    final savedNote = await NotesDatabase.instance.createNote(note);

    final updated = selected!.copyWith(notes: [...?selected.notes, savedNote]);

    state = state.copyWith(
      profiles: [
        for (final profile in state.profiles)
          if (profile.id == selected.id) updated else profile,
      ],
      selectedProfile: updated,
    );
  }

  Future<void> deleteNote(NotesModel note) async {
    final noteId = note.id;
    if (noteId == null) return;

    final profileIndex = state.profiles.indexWhere(
      (profile) =>
          (profile.notes ?? []).any((existing) => existing.id == noteId),
    );
    await NotesDatabase.instance.deleteNote(noteId);

    final profile = state.profiles[profileIndex];
    final updatedProfile = profile.copyWith(
      notes: (profile.notes ?? [])
          .where((existing) => existing.id != noteId)
          .toList(),
    );
    final profiles = [...state.profiles]..[profileIndex] = updatedProfile;

    state = state.copyWith(
      profiles: profiles,
      selectedProfile: state.selectedProfile?.id == profile.id
          ? updatedProfile
          : state.selectedProfile,
    );
  }

  Future<void> removeAllNote(ProfileModel profile) async {
    final index = state.profiles.indexWhere((p) => p.id == profile.id);

    final tempProfile = state.profiles[index];

    await NotesDatabase.instance.deleteNotesForProfile(profile.id!);

    final updatedProfile = tempProfile.copyWith(notes: []);
    final profiles = [...state.profiles]..[index] = updatedProfile;

    state = state.copyWith(
      profiles: profiles,
      selectedProfile: state.selectedProfile?.id == profile.id
          ? updatedProfile
          : state.selectedProfile,
    );
  }

  Future<void> updateNote(NotesModel updatedNote) async {
    final id = updatedNote.id;

    final profileIndex = state.profiles.indexWhere(
      (profile) => (profile.notes ?? []).any((note) => note.id == id),
    );

    await NotesDatabase.instance.updateNote(updatedNote);

    final profile = state.profiles[profileIndex];
    final updatedProfile = profile.copyWith(
      notes: [
        for (final note in profile.notes ?? [])
          if (note.id == id) updatedNote else note,
      ],
    );
    final profiles = [...state.profiles]..[profileIndex] = updatedProfile;

    state = state.copyWith(
      profiles: profiles,
      selectedProfile: state.selectedProfile?.id == profile.id
          ? updatedProfile
          : state.selectedProfile,
    );
  }
}

@riverpod
List<ProfileModel> profiles(Ref ref) {
  final allProfiles = ref.watch(profileProvider);

  return allProfiles.profiles;
}

@riverpod
int limit(Ref ref) {
  final allProfiles = ref.watch(profileProvider);

  return allProfiles.profileLimit;
}

@riverpod
ProfileModel? selectedProfile(Ref ref) {
  final allProfiles = ref.watch(profileProvider);

  return allProfiles.selectedProfile;
}

@riverpod
List<NotesModel> notes(Ref ref) {
  final profileNotes = ref.watch(profileProvider);

  List<NotesModel> allnotes = [];

  for (final profile in profileNotes.profiles) {
    allnotes.addAll(profile.notes!);
  }

  return allnotes;
}
