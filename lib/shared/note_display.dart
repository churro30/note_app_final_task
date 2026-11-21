import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_task3/data/models/notes_model.dart';
import 'package:notes_app_task3/screens/notes_management/manage_note.dart';

class NoteDisplay extends ConsumerStatefulWidget {
  const NoteDisplay({super.key, required this.notes});

  final List<NotesModel> notes;
  @override
  ConsumerState<NoteDisplay> createState() => _NoteDisplayState();
}

class _NoteDisplayState extends ConsumerState<NoteDisplay> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        final note = widget.notes[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageNote(state: 'preview', note: note),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(minHeight: 200),
            decoration: BoxDecoration(
              color: note.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(note.content),
              ],
            ),
          ),
        );
      },
    );
  }
}
