import 'package:flutter/material.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/theme.dart';
import 'package:notes_app_task3/screens/profile_management/select_profile/select_profile.dart';
import 'package:notes_app_task3/screens/onboarding/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool lastPage = false;

  Future<void> _completeOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                lastPage = index == 2;
              });
            },
            children: [
              IntroScreen(title: introScreenText1, image: introScreen1Image),
              IntroScreen(title: introScreenText2, image: introScreen2Image),
              IntroScreen(title: introScreenText3, image: introScreen3Image),
            ],
          ),

          // Dot Indicators
          Container(
            alignment: Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip Screens
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                    _completeOnBoarding();
                  },
                  child: Text(
                    skip,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                // Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: ThemeColors.textColor,
                  ),
                ),

                // Next or Done
                lastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectProfile(),
                            ),
                          );
                          _completeOnBoarding();
                        },
                        child: Text(
                          done,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          next,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
