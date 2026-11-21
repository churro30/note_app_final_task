import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/theme.dart';
import 'package:notes_app_task3/screens/profile_management/select_profile/profile_card.dart';
import 'package:notes_app_task3/screens/profile_management/profile_screen.dart';
import 'package:notes_app_task3/screens/side_drawer/side_drawer_border.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profiles = profileState.profiles;
    final selectedProfile = profileState.selectedProfile;

    return Drawer(
      child: ListView.builder(
        itemCount: profiles.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              padding: EdgeInsetsGeometry.zero,
              child: Column(
                children: [
                  Text(
                    activeProfile,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: ProfileCard(
                      profile: selectedProfile!,
                      widget: ProfileScreen(
                        state: 'preview',
                        profile: selectedProfile,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (index == profiles.length + 1) {
            final canCreateProfile = profileState.profileLimit < 5;

            return SideDrawerBorder(
              isSelected: true,
              child: ListTile(
                leading: Icon(
                  LucideIcons.userRoundPen,
                  color: canCreateProfile ? null : Colors.grey,
                ),
                title: Text(
                  canCreateProfile ? newProfileCreate : profileLimitMessage,
                ),
                onTap: () {
                  if (!canCreateProfile) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ProfileScreen(state: 'create'),
                    ),
                  );
                },
              ),
            );
          }

          final profile = profiles[index - 1];
          final isSelected = profile.id == selectedProfile?.id;
          return SideDrawerBorder(
            isSelected: isSelected,
            child: ListTile(
              title: Text(profile.userName.toString()),
              selected: isSelected,
              selectedColor: ThemeColors.accentColor,
              tileColor: isSelected ? Colors.amber[100] : null,
              trailing: IconButton(
                onPressed: () {
                  ref.read(profileProvider.notifier).selectProfile(profile);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        state: 'preview',
                        profile: profiles[index - 1],
                      ),
                    ),
                  );
                },
                icon: Icon(LucideIcons.arrowBigRightDash),
              ),
              onTap: () async {
                await ref.read(profileProvider.notifier).selectProfile(profile);
              },
            ),
          );
        },
      ),
    );
  }
}
