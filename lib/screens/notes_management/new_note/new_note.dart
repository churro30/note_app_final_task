import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/models/notes_model.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/screens/main_screens.dart';
import 'package:notes_app_task3/screens/notes_management/new_note/note_background_color.dart';
import 'package:notes_app_task3/shared/custom_field.dart';
import 'package:notes_app_task3/shared/field_title.dart';

class NewNote extends ConsumerStatefulWidget {
  const NewNote({super.key, this.state, this.note});
  final String? state;
  final NotesModel? note;

  @override
  ConsumerState<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends ConsumerState<NewNote> {
  String title = '';
  String noteText = '';
  Color? selectedColor;
  final _formKey = GlobalKey<FormState>();

  void _createNote() {
    final newNote = NotesModel(
      profileID: ref.read(profileProvider).selectedProfile!.id!,
      title: title,
      color: selectedColor ?? Colors.grey,
      content: noteText,
    );
    ref.read(profileProvider.notifier).newNote(newNote);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(newNoteMessage)));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreens()),
    );
  }

  void _saveNote() {
    final oldNote = widget.note;

    final updatedNote = NotesModel(
      id: oldNote!.id,
      profileID: ref.read(profileProvider).selectedProfile!.id!,

      title: title,
      content: noteText,
      color: selectedColor ?? oldNote.color,
    );

    ref.read(profileProvider.notifier).updateNote(updatedNote);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(updateNoteMessage)));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreens()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FieldTitle(title: noteTitle),
              CustomFormField(
                value: widget.state == 'preview' ? widget.note?.title : '',
                state: widget.state,
                onSaved: (value) => title = value!,
                fieldType: 'Text',
                fieldLabel: 'title',
                length: 15,
              ),
              Divider(),

              const SizedBox(height: 30),

              Text(
                backgroundColorMessage,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: backgroundColors.entries.map((entry) {
                  return NoteBackgroundColor(
                    state: widget.state,
                    colorText: entry.key,
                    color: entry.value,
                    isSelected: widget.state == 'preview'
                        ? widget.note?.color == entry.value
                        : selectedColor == entry.value,
                    onTap: () {
                      setState(() {
                        selectedColor = entry.value;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 50),
              Divider(),
              const SizedBox(height: 30),

              Text(
                noteTextMessage,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              CustomFormField(
                value: widget.state == 'preview' ? widget.note?.content : '',
                state: widget.state,
                onSaved: (value) => noteText = value!,
                fieldType: 'Text',
                fieldLabel: 'text',
              ),
              const SizedBox(height: 30),
              (widget.state == 'preview')
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            _formKey.currentState!.save();
                            widget.state == 'new' ? _createNote() : _saveNote();
                          },
                          child: Text(
                            widget.state == 'new' ? newNoteCreate : updateNote,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(width: 20),
                        if (widget.state == 'edit')
                          FilledButton(
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: Text(deleteNoteConfirm),
                                  content: Text(content),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: Text(
                                        cancel,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: Text(
                                        deleteNote,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed != true) return;

                              await ref
                                  .read(profileProvider.notifier)
                                  .deleteNote(widget.note!);
                              if (!context.mounted) return;

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreens(),
                                ),
                              );
                            },
                            child: Text(
                              deleteNote,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                      ],
                    ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
