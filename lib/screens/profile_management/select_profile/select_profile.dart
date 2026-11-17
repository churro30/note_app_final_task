import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/screens/profile_management/select_profile/profile_card.dart';
import 'package:notes_app_task3/screens/main_screens.dart';
import 'package:notes_app_task3/screens/profile_management/profile_screen.dart';

class SelectProfile extends ConsumerStatefulWidget {
  const SelectProfile({super.key});

  @override
  ConsumerState<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends ConsumerState<SelectProfile> {
  @override
  Widget build(BuildContext context) {
    final profilesState = ref.watch(profileProvider);
    final profiles = profilesState.profiles;
    final limit = ref.watch(limitProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Profiles'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profiles.isEmpty
                ? Center(
                    child: Text(
                      noProfileMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Text(
                          selectProfileMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: profiles.length,
                            itemBuilder: (context, index) {
                              final profile = profiles[index];
                              return ProfileCard(
                                profile: profile,
                                widget: MainScreens(),
                                deleteIcon: const Icon(LucideIcons.trash),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

            SizedBox(height: 5),
            FilledButton(
              onPressed: () {
                if (limit < 5) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ProfileScreen(state: 'create'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(profileLimitMessage)));
                }
              },
              child: Text(
                newProfileCreate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
