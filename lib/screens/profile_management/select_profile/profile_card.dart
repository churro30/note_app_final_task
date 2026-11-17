import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_task3/data/models/profile_model.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/theme.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    this.deleteIcon,
    required this.widget,
  });

  final ProfileModel profile;
  final Icon? deleteIcon;
  final Widget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeColors.accentColor,
        border: Border.all(color: ThemeColors.textColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          ref.read(profileProvider.notifier).selectProfile(profile);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(File(profile.image!)),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Name: ${profile.userName}\nAge: ${profile.age}\nGender: ${profile.gender}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              child: deleteIcon == null
                  ? null
                  : IconButton(
                      onPressed: () {
                        ref
                            .read(profileProvider.notifier)
                            .deleteProfile(profile);
                      },
                      icon: deleteIcon!,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
