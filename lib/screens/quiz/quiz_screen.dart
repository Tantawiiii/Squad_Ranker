import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_resource/app_colors.dart';
import '../../app_resource/app_strings.dart';
import '../../app_resource/app_text_styles.dart';
import '../../core/cubits/leaugeCubit/leauge_cubit.dart';
import '../../core/cubits/leaugeCubit/leauge_state.dart';
import '../../core/cubits/quizCubit/quiz_cubit.dart';
import '../../core/cubits/quizCubit/quiz_state.dart';
import '../../core/models/player_model.dart';
import '../../widgets/app_bar.dart';
import 'widgets/players_widget.dart';
import 'widgets/slidable_button_widget.dart';
import 'widgets/show_alert_dailog.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool hasCheckedAnswers = false;
  List<Player?> selectedPlayers = List.filled(5, null);
  late QuizCubit quizCubit;
  List<Player> availablePlayers = [];
  int? roundScore;
  bool showScoreWidget = false;

  @override
  void initState() {
    super.initState();
    hasCheckedAnswers = false;
    quizCubit = context.read<QuizCubit>();

    // Check if enough leagues are selected
    final selectedLeagues = context.read<LeaugeCubit>().state.sellectedLeauges;
    if (selectedLeagues.length >= 2) {
      quizCubit.initQuizWithShortInfo();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least 2 leagues')),
        );
      });
    }
  }

  void addPlayer(Player player) {
    setState(() {
      int index = selectedPlayers.indexWhere((p) => p == null);
      if (index != -1) {
        selectedPlayers[index] = player;
        availablePlayers.remove(player);
      }
    });
  }

  void removePlayer(int index) {
    final player = selectedPlayers[index];
    if (player != null) {
      setState(() {
        selectedPlayers[index] = null;
        availablePlayers.add(player);
      });
    }
  }

  void checkAnswer() {
    if (selectedPlayers.every((player) => player != null)) {
      quizCubit.checkAnswers(selectedPlayers.cast<Player>());
      setState(() {
        hasCheckedAnswers = true;
        showScoreWidget = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select all 5 players before checking")),
      );
    }
  }

  void resetQuiz() {
    setState(() {
      selectedPlayers = List.filled(5, null);
      hasCheckedAnswers = false;
      showScoreWidget = false;
    });
    quizCubit.startNewQuiz();
  }

  int getSelectedPlayersCount() {
    return selectedPlayers.where((player) => player != null).length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaugeCubit, LeaugeState>(
      listener: (context, state) {
        // Reload quiz when selected leagues change
        if (state.sellectedLeauges.length >= 2) {
          resetQuiz();
        }
      },
      child: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          if (state is QuizError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is QuizLoaded) {
            setState(() {
              availablePlayers = List.from(state.players);
              selectedPlayers = List.filled(5, null);
              hasCheckedAnswers = false;
              roundScore = null;
            });
          } else if (state is QuizAnswersChecked) {
            setState(() {
              roundScore = state.roundScore;
            });
          }
        },
        builder: (context, state) {
          final selectedLeagues = context.read<LeaugeCubit>().state.sellectedLeauges;

          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: 'Squad Ranker',
                  onBack: () async {
                    final shouldExit = await showExitQuizDialog(context);
                    if (shouldExit) {
                      Navigator.pushNamed(context, 'homeScreen');
                    }
                  },
                ),

                if (selectedLeagues.length < 2)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Please select at least 2 leagues from leagues screen',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                Expanded(
                  child: selectedLeagues.length >= 2
                      ? _buildQuizContent(state)
                      : Center(child: Text('Select more leagues to play')),
                ),

                if (showScoreWidget && roundScore != null)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    color: AppColors.scoreContainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+$roundScore',
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

                if (!hasCheckedAnswers)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppStrings.organizePlayersByTheir,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.hinitText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 32, right: 16, left: 16),
                  child: Row(
                    children: [
                      if (!hasCheckedAnswers)
                        Expanded(
                          child: FilledButton(
                            onPressed: getSelectedPlayersCount() == 5
                                ? checkAnswer
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                getSelectedPlayersCount() == 5
                                    ? AppColors.indecatorColor
                                    : AppColors.lightGray,
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                            child: Text(
                              AppStrings.check,
                              style: TextStyle(
                                fontSize: 24,
                                color: getSelectedPlayersCount() == 5
                                    ? AppColors.white
                                    : AppColors.hinitText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      if (hasCheckedAnswers)
                        Expanded(
                          child: FilledButton(
                            onPressed: resetQuiz,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.indecatorColor),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                            child: const Text(
                              AppStrings.newQuiz,
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColors.background,
                                fontWeight: FontWeight.w700,
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
        },
      ),
    );
  }

  Widget _buildQuizContent(QuizState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).size.width / 14,
            ),
            child: Column(
              children: List.generate(5, (index) {
                final player = selectedPlayers[index];
                return SlidableButtonWidget(
                  positionIndex: index + 1,
                  onPressed: (context) {},
                  name: player?.name,
                  price: player?.marketValue.toString() ?? '0',
                  answerIsTrue: hasCheckedAnswers
                      ? state is QuizAnswersChecked
                      ? state.results.length > index
                      ? state.results[index]
                      : false
                      : false
                      : null,
                  onTapRemove: hasCheckedAnswers
                      ? null
                      : () => removePlayer(index),
                );
              }),
            ),
          ),

          if (state is QuizLoaded &&
              getSelectedPlayersCount() < 5 &&
              !hasCheckedAnswers)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availablePlayers.map((player) {
                    return PlayersWidget(
                      name: player.name,
                      position: player.position ?? "N/A",
                      number: player.number ?? '?',
                      choosenPlayer: false,
                      onTap: hasCheckedAnswers
                          ? null
                          : () => addPlayer(player),
                    );
                  }).toList(),
                ),
              ),
            ),

          if (state is QuizLoaded && availablePlayers.isEmpty && !hasCheckedAnswers)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No players available'),
            ),

          if (state is QuizLoading)
            const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.indecatorColor,
                    color: AppColors.gray,
                    strokeAlign: 4,
                  ),
                )),
        ],
      ),
    );
  }
}