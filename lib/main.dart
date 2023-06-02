import 'package:flutter/material.dart';

import 'package:quizz/screens/start_screen.dart';
import 'package:quizz/screens/question_screen.dart';
import 'package:quizz/screens/results_screen.dart';
import 'package:quizz/data/questions.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final List<String> selectedAnswers = [];
  var activeScreen = #start_screen;

  void switchScreen() {
    setState(() {
      activeScreen = switch (activeScreen) {
        #start_screen => #question_screen,
        #question_screen => #results_screen,
        #results_screen => #start_screen,
        _ => throw Exception('Unknown screen: $activeScreen')
      };
    });
  }

  void chooseAnswer(String answer) {
    setState(() => selectedAnswers.add(answer));
  }

  @override
  build(context) {
    if (activeScreen == #start_screen) {
      selectedAnswers.clear();
    }

    final screenWidget = switch (activeScreen) {
      #start_screen => StartScreen(onQuizStarted: switchScreen),
      #question_screen => QuestionScreen(
          questions: questions,
          onAnswerSelected: chooseAnswer,
          onAllQuestionsAnswered: switchScreen,
        ),
      #results_screen => ResultsScreen(
          questions: questions,
          selectedAnswers: selectedAnswers,
          onQuizRestarted: switchScreen,
        ),
      _ => throw Exception('Unknown screen: $activeScreen')
    };

    return MaterialApp(
        home: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 106, 27, 154),
                        Color.fromARGB(255, 180, 57, 202)
                      ]),
                ),
                child: screenWidget)));
  }
}
