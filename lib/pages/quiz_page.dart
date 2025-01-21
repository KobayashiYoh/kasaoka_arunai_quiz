import 'package:flutter/material.dart';
import 'package:kasaoka_arunai_quiz/constants/constants.dart';
import 'package:kasaoka_arunai_quiz/models/quiz.dart';
import 'package:kasaoka_arunai_quiz/pages/result_page.dart';

import '../components/explanation_section.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _score = 0;
  int _currentQuizIndex = 0;
  bool? _selectedAnswer;
  double _bannerDy = -1;

  Quiz get _currentQuiz => Constants.quizData.elementAt(_currentQuizIndex);

  bool get _hasSelectedAnswer => _selectedAnswer != null;

  bool get _isMatchAnswer => _selectedAnswer == _currentQuiz.answer;

  bool get _isFinalQuiz => _currentQuizIndex == Constants.quizData.length - 1;

  String get _goToNextButtonText => _isFinalQuiz ? '結果を見る' : '次へ';

  void _onTapSelection(bool selectedAnswer) {
    if (_hasSelectedAnswer) return;
    setState(() {
      _selectedAnswer = selectedAnswer;
      _bannerDy = 0;
    });
    if (_isMatchAnswer) {
      setState(() {
        _score++;
      });
    }
  }

  void _onTapNext(BuildContext context) {
    if (_isFinalQuiz) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score: _score)),
      );
      return;
    }
    setState(() {
      _selectedAnswer = null;
      _currentQuizIndex++;
      _bannerDy = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedSlide(
              offset: Offset(0, _bannerDy),
              duration: const Duration(milliseconds: 100),
              child: _hasSelectedAnswer
                  ? _ResultBanner(
                      isMatchAnswer: _isMatchAnswer,
                      onPressedAction: () => _onTapNext(context),
                      actionButtonText: _goToNextButtonText,
                    )
                  : const SizedBox.shrink(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 64.0),
                  const SizedBox(height: 64.0),
                  Text(
                    'Q${_currentQuizIndex + 1}. ${_currentQuiz.question}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                        child: _SelectionButton(
                          onPressed: () => _onTapSelection(true),
                          answer: true,
                          hasSelectedAnswer: _hasSelectedAnswer,
                        ),
                      ),
                      const SizedBox(width: 32.0),
                      Expanded(
                        child: _SelectionButton(
                          onPressed: () => _onTapSelection(false),
                          answer: false,
                          hasSelectedAnswer: _hasSelectedAnswer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64.0),
                  if (_hasSelectedAnswer)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16.0),
                        ExplanationSection(
                          title: '結果',
                          text: _isMatchAnswer ? '正解' : '不正解',
                        ),
                        const SizedBox(height: 16.0),
                        ExplanationSection(
                          title: '解答',
                          text:
                              '${_currentQuiz.answer ? 'ある' : 'ない'}（あなたの選択肢「${_selectedAnswer! ? 'ある' : 'ない'}」）',
                        ),
                        const SizedBox(height: 16.0),
                        ExplanationSection(
                          title: '解説',
                          text: _currentQuiz.description,
                        ),
                      ],
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _hasSelectedAnswer ? () => _onTapNext(context) : null,
                      child: Text(_goToNextButtonText),
                    ),
                  ),
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  const _SelectionButton({
    required this.onPressed,
    required this.answer,
    required this.hasSelectedAnswer,
  });

  final void Function()? onPressed;
  final bool answer;
  final bool hasSelectedAnswer;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: hasSelectedAnswer ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: hasSelectedAnswer ? Colors.grey[300] : null,
        side: BorderSide(
          width: 2.0,
          color: hasSelectedAnswer ? Colors.transparent : Colors.black,
        ),
        overlayColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(
              answer ? 'ある' : 'ない',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: hasSelectedAnswer ? Colors.grey[400] : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({
    required this.isMatchAnswer,
    required this.onPressedAction,
    required this.actionButtonText,
  });

  final bool isMatchAnswer;
  final void Function() onPressedAction;
  final String actionButtonText;

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      content: Row(
        children: [
          isMatchAnswer
              ? const Icon(
                  Icons.circle_outlined,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.blue,
                ),
          const SizedBox(width: 8.0),
          Text(isMatchAnswer ? '正解' : '不正解'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressedAction,
          child: Text(
            actionButtonText,
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
        ),
      ],
    );
  }
}
