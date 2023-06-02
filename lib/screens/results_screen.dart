import 'package:flutter/material.dart';
import 'package:quizz/models/quiz_question.dart';

typedef Summary = List<Map<String, Object>>;

class ResultsScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final void Function() onQuizRestarted;
  final List<String> selectedAnswers;

  const ResultsScreen(
      {required this.questions,
      required this.selectedAnswers,
      required this.onQuizRestarted,
      super.key});

  @override
  build(context) {
    final totalQuestions = summary.length;
    final correctAnswers = summary
        .where((item) => item['selectedAnswer'] == item['correctAnswer'])
        .length;

    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
                'You answered $correctAnswers out of $totalQuestions questions correctly!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.purple[100],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            QuestionsSummary(summary),
            const SizedBox(height: 30),
            TextButton.icon(
                onPressed: onQuizRestarted,
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                icon: const Icon(Icons.replay),
                label: const Text('Restart Quiz')),
          ]),
        ));
  }

  Summary get summary {
    final Summary summary = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      final item = questions[i];
      final selectedAnswer = selectedAnswers[i];
      final correctAnswer = item.answers[0];
      summary.add({
        'question_index': i,
        'question': item.question,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
      });
    }

    return summary;
  }
}

class QuestionsSummary extends StatelessWidget {
  final Summary summary;
  const QuestionsSummary(this.summary, {super.key});

  @override
  build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summary
              .map((item) =>
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:
                                item['selectedAnswer'] == item['correctAnswer']
                                    ? Colors.pink[200]
                                    : Colors.cyan[200],
                            shape: BoxShape.circle),
                        child: Text(
                            ((item['question_index'] as int) + 1).toString())),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['question'].toString(),
                                  style: TextStyle(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(item['selectedAnswer'].toString(),
                                  style: TextStyle(color: Colors.pink[200])),
                              const SizedBox(height: 5),
                              Text(item['correctAnswer'].toString(),
                                  style: TextStyle(color: Colors.cyan[400])),
                            ]),
                      ),
                    )
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
