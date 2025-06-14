import 'package:app_b_804/core/extensions/app_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_resource/app_colors.dart';
import '../../app_resource/app_strings.dart';
import '../../app_resource/app_text_styles.dart';
import '../../core/cubits/quizCubit/quiz_cubit.dart';
import '../../widgets/app_bar.dart';
import 'widgets/players_widget.dart';
import 'widgets/slidable_button_widget.dart';

enum QuizMethod { byLeagueSeason, byHeaderInfo }

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizMethod selectedMethod = QuizMethod.byHeaderInfo;
  bool hasCheckedAnswers = false;

  List<Map<String, dynamic>> selectedPlayers = List.generate(
      5,
      (_) => {
            'name': null,
            'price': '12',
            'answerIsTrue': null,
          });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      QuizCubit.quizCubit = context.read<QuizCubit>();
      _loadQuiz();
    });
  }

  void _loadQuiz() {
    if (selectedMethod == QuizMethod.byLeagueSeason) {
      QuizCubit.quizCubit!.initQuiz();
    } else {
      QuizCubit.quizCubit!.initQuizWithShortInfo();
    }
  }

  void addPlayer(String name, String price, bool answerIsTrue) {
    setState(() {
      int index =
          selectedPlayers.indexWhere((player) => player['name'] == null);
      if (index != -1) {
        selectedPlayers[index] = {
          'name': name,
          'price': price,
          'answerIsTrue': answerIsTrue,
        };
      }
    });
  }

  void checkAnswer() {
    final cubit = QuizCubit.quizCubit!;
    cubit.checkAnswers(selectedPlayers);
    final correctAnswers = cubit.playersList;

    if (correctAnswers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No correct answers loaded. Please reload quiz.")),
      );
      return;
    }

    setState(() {
      hasCheckedAnswers = true;

      for (int i = 0; i < selectedPlayers.length; i++) {
        if (i < correctAnswers.length) {
          int userPrice = cubit.parsePrice(selectedPlayers[i]['price']);
          int correctPrice = cubit.parsePrice(correctAnswers[i]['price']);

          selectedPlayers[i]['answerIsTrue'] = userPrice == correctPrice;
        } else {
          selectedPlayers[i]['answerIsTrue'] = false;
        }
      }
    });
  }

  void resetQuiz() {
    setState(() {
      hasCheckedAnswers = false;
      selectedPlayers = List.generate(
          5,
          (_) => {
                'name': null,
                'price': '12',
                'answerIsTrue': null,
              });
    });
    _loadQuiz();
  }

  int getSelectedPlayersCount() {
    return selectedPlayers.where((player) => player['name'] != null).length;
  }

  @override
  Widget build(BuildContext context) {
    QuizCubit.quizCubit = context.watch<QuizCubit>();
    final cubit = QuizCubit.quizCubit!;
    final state = cubit.state;

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
                      children: selectedPlayers.asMap().entries.map((entry) {
                        int index = entry.key;
                        var player = entry.value;

                        return SlidableButtonWidget(
                          name: player['name'],
                          price: player['price'] ?? '0',
                          answerIsTrue: player['answerIsTrue'],
                          onPressed: (context) {},
                          onTapRemove: () {
                            setState(() {
                              selectedPlayers[index] = {
                                'name': null,
                                'price': '0',
                                'answerIsTrue': null,
                              };
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  if (state.players.isNotEmpty && getSelectedPlayersCount() < 5)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.players.map((player) {
                            return PlayersWidget(
                              choosenPlayer: true,
                              name: player['name'],
                              position: player['position'] ?? "N/A",
                              number: player['number'],
                              onTap: () {
                                if (getSelectedPlayersCount() < 5) {
                                  addPlayer(
                                      player['name'], player['price'], false);
                                  setState(() {
                                    cubit.playersList.remove(player);
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  else if (state.players.isEmpty && !state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Loading players...'),
                    )
                  else if (getSelectedPlayersCount() >= 5)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'All required players selected (5/5)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (cubit.score > 0)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              color: AppColors.scoreContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+${cubit.score}',
                    style: AppTextStyles.header48.copyWith(
                      fontSize: 32,
                      color: AppColors.buttonBackgroundColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/Star 1.png',
                    width: 35,
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: checkAnswer,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.lightGray),
                    ),
                    child: Text(
                      AppStrings.check,
                      style: AppTextStyles.header24.copyWith(
                        color: AppColors.organizePlayersByTheir,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (hasCheckedAnswers)
                  Expanded(
                    child: FilledButton(
                      onPressed: resetQuiz,
                      child: Text(
                        AppStrings.newQuiz,
                        style: AppTextStyles.header24.copyWith(
                          color: AppColors.organizePlayersByTheir,
                        ),
                      ),
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
