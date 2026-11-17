import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/theme.dart';
import 'package:notes_app_task3/screens/home_screen/home_screen.dart';
import 'package:notes_app_task3/screens/notes_management/all_notes.dart';
import 'package:notes_app_task3/screens/notes_management/manage_note.dart';
import 'package:notes_app_task3/screens/side_drawer/side_drawer.dart';

class MainScreens extends ConsumerStatefulWidget {
  const MainScreens({super.key});

  @override
  ConsumerState<MainScreens> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreens> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    }

    _pageController.animateToPage(
      index - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: Text(
          'Notes App',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [HomeScreen(), AllNotes()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex + 1,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.menu),
            label: profiles,
          ),
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: home),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.notebook),
            label: allNotes,
          ),
        ],
      ),
      floatingActionButton: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageNote(state: 'new')),
          );
        },
        child: Icon(LucideIcons.plus, color: ThemeColors.textColor),
      ),
    );
  }
}
