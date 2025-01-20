import 'package:flutter/material.dart';
import 'package:kasaoka_arunai_quiz/constants/constants.dart';
import 'package:kasaoka_arunai_quiz/models/quiz.dart';
import 'package:kasaoka_arunai_quiz/pages/result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _score = 0;
  int _currentQuizIndex = 0;
  bool? _selectedAnswer;

  Quiz get _currentQuiz => Constants.quizData.elementAt(_currentQuizIndex);

  bool get _hasSelectedAnswer => _selectedAnswer != null;

  bool get _isMatchAnswer => _selectedAnswer == _currentQuiz.answer;

  bool get _isFinalQuiz => _currentQuizIndex == Constants.quizData.length - 1;

  Widget _resultBanner() {
    return MaterialBanner(
      content: Row(
        children: [
          _isMatchAnswer
              ? const Icon(
                  Icons.circle_outlined,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.blue,
                ),
          const SizedBox(width: 8.0),
          Text(_isMatchAnswer ? '正解' : '不正解'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => _onTapNext(context),
          child: const Text('次へ'),
        ),
      ],
    );
  }

  void _onTapSelection(bool selectedAnswer) {
    if (_hasSelectedAnswer) return;
    setState(() {
      _selectedAnswer = selectedAnswer;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                  height: 64.0,
                  child: _selectedAnswer == null
                      ? const SizedBox.shrink()
                      : _resultBanner()),
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
                    _ExplanationSection(
                      title: '結果',
                      text: _isMatchAnswer ? '正解' : '不正解',
                    ),
                    const SizedBox(height: 16.0),
                    _ExplanationSection(
                      title: '解答',
                      text:
                          '${_currentQuiz.answer ? 'ある' : 'ない'}（あなたの選択肢「${_selectedAnswer! ? 'ある' : 'ない'}」）',
                    ),
                    const SizedBox(height: 16.0),
                    _ExplanationSection(
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
                  child: Text(_isFinalQuiz ? '結果を見る' : '次へ'),
                ),
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplanationSection extends StatelessWidget {
  const _ExplanationSection({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text),
      ],
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
        backgroundColor: hasSelectedAnswer ? Colors.grey[400] : null,
        side: const BorderSide(width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Text(
              answer ? 'ある' : 'ない',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
