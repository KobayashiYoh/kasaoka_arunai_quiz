import 'package:flutter/material.dart';
import 'package:kasaoka_arunai_quiz/components/explanation_section.dart';
import 'package:kasaoka_arunai_quiz/constants/constants.dart';
import 'package:kasaoka_arunai_quiz/pages/quiz_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final howToPlayText =
        '人口4万人ほどの都市「岡山県笠岡市」に\n「ある」か「ない」かを答えるだけ。\n（全${Constants.quizData.length}問）';
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  '笠岡あるないクイズ',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: ExplanationSection(
                  title: '遊び方',
                  text: howToPlayText,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                child: const Text('はじめる'),
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
