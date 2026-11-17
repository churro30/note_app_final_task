import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/models/notes_model.dart';
import 'package:notes_app_task3/screens/notes_management/new_note/new_note.dart';

// New Note & Edit Note

class ManageNote extends StatefulWidget {
  const ManageNote({super.key, required this.state, this.note});

  final String state;
  final NotesModel? note;

  @override
  State<ManageNote> createState() => _ManageNoteState();
}

class _ManageNoteState extends State<ManageNote> {
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.state == 'edit';
  }

  @override
  Widget build(BuildContext context) {
    final isNewNote = widget.state == 'new';

    return Scaffold(
      appBar: AppBar(
        title: Text(manageNote),
        actions: [
          isNewNote
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(LucideIcons.stickyNotePlus),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                  icon: Icon(isEditMode ? LucideIcons.edit : LucideIcons.eye),
                ),
        ],
      ),
      body: isNewNote
          ? NewNote(state: widget.state)
          : NewNote(state: isEditMode ? 'edit' : 'preview', note: widget.note),
    );
  }
}
