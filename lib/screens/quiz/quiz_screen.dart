import 'package:app_b_804/core/extensions/app_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../app_resource/app_colors.dart';
import '../../app_resource/app_strings.dart';
import '../../app_resource/app_text_styles.dart';
import '../../core/cubits/quizCubit/quiz_cubit.dart';
import '../../widgets/app_bar.dart';
import 'widgets/players_widget.dart';
import 'widgets/slidable_button_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final GlobalKey _slidableButtonKey = GlobalKey();
  final GlobalKey _playerWidgetKey = GlobalKey();
  final GlobalKey _checkButtonKey = GlobalKey();
  List<TargetFocus> targets = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      QuizCubit.quizCubit!.initQuiz();
      _createTutorial();
      _showTutorialIfNeeded();
    });
  }

  void _createTutorial() {
    targets = [
      TargetFocus(
        identify: "SlideButton",
        keyTarget: _slidableButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              "Slide this button to select the correct answer.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      TargetFocus(
        identify: "PlayerWidget",
        keyTarget: _playerWidgetKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Text(
              "These are your squad players. You can view their info here.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      TargetFocus(
        identify: "CheckButton",
        keyTarget: _checkButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Text(
              "Press this to check your squad's ranking.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    ];
  }

  Future<void> _showTutorialIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seenQuizTutorial') ?? false;

    if (!seen) {
      TutorialCoachMark(
        targets: targets,
        colorShadow: Colors.black,
        textSkip: "SKIP",
        paddingFocus: 10,
        opacityShadow: 0.8,
      ).show(context: context);
      await prefs.setBool('seenQuizTutorial', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    QuizCubit.quizCubit = context.watch<QuizCubit>();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: 'Squad Ranker',
            onBack: () {
              Navigator.pushNamed(context, 'homeScreen');
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: AppMediaQueryExtension(context).screenWidth / 14,
                    ),
                    child: Column(
                      children: [
                        SlidableButtonWidget(
                          key: _slidableButtonKey,
                          name: 'James Garner',
                          answerIsTrue: false,
                          onPressed: (context) {},
                          price: '12',
                        ),
                        SlidableButtonWidget(
                          name: 'James Garner',
                          answerIsTrue: true,
                          onPressed: (context) {},
                          price: '12',
                        ),
                        SlidableButtonWidget(
                          onPressed: (context) {},
                          price: '12',
                        ),
                        SlidableButtonWidget(
                          onPressed: (context) {},
                          price: '12',
                        ),
                        SlidableButtonWidget(
                          onPressed: (context) {},
                          price: '12',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PlayersWidget(
                            key: _playerWidgetKey,
                            choosenPlayer: true,
                            name: 'Nathan Baxter',
                            position: 'Midfielder',
                            number: '8',
                          ),
                          PlayersWidget(
                            choosenPlayer: false,
                            name: 'Nathan Baxter',
                            position: 'Midfielder',
                            number: '8',
                          ),
                          PlayersWidget(
                            choosenPlayer: false,
                            name: 'Nathan Baxter',
                            position: 'Midfielder',
                            number: '8',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            child: Text(
              AppStrings.organizePlayersByTheir,
              style: AppTextStyles.header16.copyWith(
                color: AppColors.organizePlayersByTheir,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 60 / 1100 * AppMediaQueryExtension(context).screenHeight,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                key: _checkButtonKey,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.lightGray),
                ),
                onPressed: () {},
                child: Text(
                  AppStrings.check,
                  style: AppTextStyles.header24.copyWith(
                    color: AppColors.organizePlayersByTheir,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
