import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_task3/data/poviders/profile_provider.dart';
import 'package:notes_app_task3/theme.dart';
import 'package:notes_app_task3/screens/profile_management/select_profile/select_profile.dart';
import 'package:notes_app_task3/screens/main_screens.dart';
import 'package:notes_app_task3/screens/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardingCompleted =
      prefs.getBool('onboarding_completed') ?? false;
  final selectedProfileId = prefs.getInt('selected_profile_id');

  runApp(
    ProviderScope(
      child: MyApp(
        onboardingCompleted: onboardingCompleted,
        selectedProfileId: selectedProfileId,
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final bool onboardingCompleted;
  final int? selectedProfileId;

  const MyApp({
    super.key,
    required this.onboardingCompleted,
    required this.selectedProfileId,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<void> _loadedData;

  @override
  void initState() {
    super.initState();
    _loadedData = ref
        .read(profileProvider.notifier)
        .loadFromDatabase(widget.selectedProfileId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadedData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Could not load saved data: ${snapshot.error}'),
              ),
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          theme: primaryTheme,
          home: !widget.onboardingCompleted
              ? OnBoardingScreen()
              : ref.read(profileProvider).selectedProfile != null
              ? MainScreens()
              : SelectProfile(),
        );
      },
    );
  }
}
