import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/models/profile_model.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/screens/profile_management/create_profile/gender_selector.dart';
import 'package:notes_app_task3/screens/profile_management/create_profile/image_container.dart';
import 'package:notes_app_task3/screens/profile_management/create_profile/image_selector.dart';
import 'package:notes_app_task3/screens/main_screens.dart';
import 'package:notes_app_task3/shared/custom_field.dart';
import 'package:notes_app_task3/screens/profile_management/select_profile/select_profile.dart';
import 'package:notes_app_task3/shared/field_title.dart';

class CreateProfile extends ConsumerStatefulWidget {
  const CreateProfile({super.key, this.state, this.profile, this.onSaved});

  final String? state;
  final ProfileModel? profile;
  final ValueChanged<ProfileModel>? onSaved;
  @override
  ConsumerState<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends ConsumerState<CreateProfile> {
  File? _image;
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int age = 0;
  Gender? gender;

  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile == null ? null : File(pickedFile.path);
  }

  void _createProfile() {
    final selectedGender = gender!;
    final newProfile = ProfileModel(
      userName: name,
      gender: selectedGender.name,
      age: age,
      image: _image?.path,
      notes: [],
    );
    ref.read(profileProvider.notifier).addProfile(newProfile);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(newProfileMessage)));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SelectProfile()),
    );
  }

  void _saveProfile() {
    final oldProfile = widget.profile;
    final selectedGender = gender!;

    final updatedProfile = ProfileModel(
      id: oldProfile!.id,
      userName: name,
      age: age,
      gender: selectedGender.name,
      image: _image!.path,
      notes: oldProfile.notes,
    );

    ref.read(profileProvider.notifier).updateProfile(updatedProfile);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(updateProfileMessage)));
    widget.onSaved?.call(updatedProfile);
  }

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    if (profile == null) return;

    _image = profile.image == null ? null : File(profile.image!);
    gender = Gender.values.firstWhere(
      (value) => value.name == profile.gender,
      orElse: () => Gender.male,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.state == 'preview')
                ImageContainer(image: _image)
              else
                ImageSelector(
                  selectedImage: _image,
                  onPickImage: pickImage,
                  onChanged: (image) {
                    setState(() {
                      _image = image;
                    });
                  },
                ),
              SizedBox(height: 20),
              FieldTitle(title: nameField),
              CustomFormField(
                fieldType: 'letters',
                fieldLabel: 'name',
                length: 10,
                state: widget.state,
                value: widget.profile?.userName,
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 30),
              SizedBox(height: 20),
              FieldTitle(title: ageField),
              CustomFormField(
                fieldType: 'numbers',
                fieldLabel: 'age',
                state: widget.state,
                value: widget.profile?.age.toString(),
                onSaved: (value) => age = int.parse(value!),
              ),
              if (widget.state == 'preview')
                Column(
                  children: [
                    const SizedBox(height: 20),

                    Text('Gender: ${widget.profile?.gender ?? 'Not set'}'),
                  ],
                )
              else
                GenderSelector(
                  selectedGender: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              const SizedBox(height: 30),
              (widget.state == 'preview')
                  ? SizedBox()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                _formKey.currentState!.save();
                                _formKey.currentState!.save();
                                widget.state == 'create'
                                    ? _createProfile()
                                    : _saveProfile();
                              },
                              child: Text(
                                widget.state == 'create'
                                    ? newProfileCreate
                                    : updateProfile,
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
                                      title: Text(deleteProfileConfirm),
                                      content: Text(content),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            false,
                                          ),
                                          child: Text(
                                            cancel,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        ),
                                        FilledButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            true,
                                          ),
                                          child: Text(
                                            deleteProfile,
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
                                      .deleteProfile(widget.profile!);
                                  if (!context.mounted) return;

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectProfile(),
                                    ),
                                  );
                                },
                                child: Text(
                                  deleteProfile,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                          ],
                        ),
                        if (widget.state == 'edit')
                          OutlinedButton(
                            onPressed: () {
                              ref
                                  .read(profileProvider.notifier)
                                  .removeAllNote(widget.profile!);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreens(),
                                ),
                              );
                            },
                            child: Text(
                              deleteAllNotes,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
