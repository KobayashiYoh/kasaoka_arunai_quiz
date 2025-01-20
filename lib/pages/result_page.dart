import 'package:flutter/material.dart';
import 'package:kasaoka_arunai_quiz/pages/quiz_page.dart';
import 'package:kasaoka_arunai_quiz/pages/top_page.dart';
import 'package:kasaoka_arunai_quiz/utils/score_helper.dart';

import '../constants/constants.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Column(
                children: [
                  const Text('「笠岡あるないクイズ」'),
                  const SizedBox(height: 32.0),
                  Text('あなたの得点は${Constants.quizData.length}点満点中'),
                  Text(
                    '$score点',
                    style: const TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('でした。'),
                  const SizedBox(height: 32.0),
                  Text(
                    ScoreHelper.scoreMessage(score, Constants.quizData.length),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                child: const Text('もう一度遊ぶ'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TopPage()),
                  );
                },
                child: const Text('トップに戻る'),
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
