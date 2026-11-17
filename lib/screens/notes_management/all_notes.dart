import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/shared/note_display.dart';

class AllNotes extends ConsumerWidget {
  const AllNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allnotes = ref.watch(notesProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (allnotes.isEmpty)
          Text(
            allNotesMessage,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          )
        else
          Expanded(child: NoteDisplay(notes: allnotes)),
      ],
    );
  }
}
