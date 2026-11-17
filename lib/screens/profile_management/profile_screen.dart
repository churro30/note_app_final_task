import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/models/profile_model.dart';
import 'package:notes_app_task3/screens/profile_management/create_profile/create_profile.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.state, this.profile});

  final String state;
  final ProfileModel? profile;
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditMode = false;
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.state == 'edit';
    _profile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    final isCreateMode = widget.state == 'create';

    return Scaffold(
      appBar: AppBar(
        title: Text(newProfileCreate),
        centerTitle: true,
        actions: [
          isCreateMode
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(LucideIcons.userRoundPen),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                  icon: Icon(isEditMode ? Icons.person : Icons.edit),
                ),
        ],
      ),
      body: isCreateMode
          ? CreateProfile(state: 'create')
          : CreateProfile(
              state: isEditMode ? 'edit' : 'preview',
              profile: _profile,
              onSaved: (updatedProfile) {
                setState(() {
                  isEditMode = false;
                  _profile = updatedProfile;
                });
              },
            ),
    );
  }
}
