import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() onQuizStarted;

  const StartScreen({required this.onQuizStarted, super.key});

  @override
  build(context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 300,
          color: const Color.fromARGB(150, 255, 255, 255),
        ),
        const SizedBox(height: 80),
        Text('Learn Flutter the fun way!',
            style: GoogleFonts.lato(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 50),
        OutlinedButton.icon(
            onPressed: onQuizStarted,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.play_arrow),
            label: Text('Start Quiz', style: GoogleFonts.lato()))
      ],
    ));
  }
}
