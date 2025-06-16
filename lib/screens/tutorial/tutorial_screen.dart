
import 'package:flutter/material.dart';

import '../../core/database/database.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});
  static PageController pageController_ = PageController();
  static int sellectedPage = 0;
  static List<String> images_ = [
    'assets/images/how_to_play.png',
    'assets/images/how_to_play_2.png',
    'assets/images/how_to_play_3.png',
  ];

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  void initState() {
    LocalData.prefs.setBool('firstTutorial', true);
    super.initState();
  }

  void moveToPage(int getSellectedPage) {
    TutorialScreen.pageController_.animateToPage(
      getSellectedPage,
      curve: Curves.linear,
      duration: const Duration(
        milliseconds: 350,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: TutorialScreen.pageController_,
      itemCount: TutorialScreen.images_.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (TutorialScreen.sellectedPage == 3) {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'quizScreen', (context) => false);
              return;
            }
            TutorialScreen.sellectedPage += 1;
            moveToPage(TutorialScreen.sellectedPage);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  TutorialScreen.images_[index],
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
