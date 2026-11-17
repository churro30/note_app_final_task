import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/shared/note_display.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final profilesState = ref.watch(profileProvider);
    final profile = profilesState.selectedProfile;
    final notes = profile?.notes ?? [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (notes.isEmpty)
          Text(
            noNoteMessage,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          )
        else
          Expanded(child: NoteDisplay(notes: notes)),
      ],
    );
  }
}
