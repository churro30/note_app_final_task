import 'package:flutter/material.dart';

final String tableNotes = 'notes';
final String tableProfiles = 'profiles';

// Gender
enum Gender { male, female }

// Note colors
Map<String, Color> backgroundColors = {
  'Cream': Color(0xFFE2D2BA),
  'Sage': Color(0xFFB7C7A9),
  'Pink': Color(0xFFE0B6AC),
  'Blue': Color(0xFFB7C8D6),
};

// Onboarding images
String introScreen1Image = 'assets/images/onboarding/intro_screen1.png';
String introScreen2Image =
    'assets/images/onboarding/intro_screen2_profile1.png';
String introScreen3Image = 'assets/images/onboarding/intro_screen3.png';

// Note labels and messages
String newNoteCreate = 'Create Note';
String updateNote = 'Update Note';
String deleteNote = 'Delete Note';
String deleteAllNotes = 'Delete All Notes';
String noNoteMessage = 'No Notes available.\nPlease create a new note first.';
String newNoteMessage = 'Note Created';
String updateNoteMessage = 'Note Updated';
String title = 'Title';
String backgroundColorMessage = 'Select a Background Color';
String noteTextMessage = 'Type your note here!';
String allNotesMessage = 'All Notes Page, \n Create Notes to Display them';
String manageNote = 'Manage your Notes';
String noteTitle = 'Note Title';

// Profile labels and messages
String newProfileCreate = 'Create Profile';
String updateProfile = 'Update Profile';
String deleteProfile = 'Delete Profile';
String activeProfile = 'Active Profile';
String selectGenderMessage = 'Please select a gender';
String selectImageMessage = 'Please select an image';
String noProfileMessage = 'No profile available.\nPlease create one first.';
String selectProfileMessage = 'Select a profile to continue';
String profileLimitWarning = 'You can only create up to 5 profiles.';
String profileLimitMessage = 'Profile Limit Reached';
String maleText = 'Male';
String femaleText = 'Female';
String newProfileMessage = 'Profile Created';
String updateProfileMessage = 'Profile Updated';
String nameField = 'Your Name';
String ageField = 'Your Age';

// Confirmation Text
String deleteNoteConfirm = 'Delete Note?';
String deleteProfileConfirm = 'Delete Profile?';
String content =
    'Are you sure you want to delete this? \n This action cannot be undone.';
String cancel = 'Cancel';

// Navigation labels
String profiles = 'Profiles';
String home = 'Home';
String allNotes = 'All Notes';

// Onboarding labels
String introScreenText1 = "Untangle your thoughts!";
String introScreenText2 = "Create up to 5 Profiles.";
String introScreenText3 = "Keep every profile's notes in one place!";
String skip = 'Skip';
String done = 'Done';
String next = 'Next';
