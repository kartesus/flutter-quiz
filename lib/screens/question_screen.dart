import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz/data/questions.dart';

import 'package:quizz/models/quiz_question.dart';

class QuestionScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final void Function(String) onAnswerSelected;
  final void Function() onAllQuestionsAnswered;

  const QuestionScreen(
      {required this.questions,
      required this.onAnswerSelected,
      required this.onAllQuestionsAnswered,
      super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  @override
  build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    final answers = currentQuestion.answers.map(buildAnswerButton).toList();
    answers.shuffle();

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.purple[100],
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              ...answers,
            ]),
      ),
    );
  }

  buildAnswerButton(String text) =>
      AnswerButton(text, onPressed: () => answerQuestion(text));

  void answerQuestion(String selectedAnswer) {
    widget.onAnswerSelected(selectedAnswer);
    if (currentQuestionIndex == questions.length - 1) {
      widget.onAllQuestionsAnswered();
    } else {
      setState(() => currentQuestionIndex++);
    }
  }
}

class AnswerButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const AnswerButton(this.text, {required this.onPressed, super.key});

  @override
  build(context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            backgroundColor: Colors.purple[900],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child:
            Text(text, style: GoogleFonts.lato(), textAlign: TextAlign.center));
  }
}
