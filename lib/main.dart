import 'package:flutter/material.dart';
import 'package:translator_app/language_translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Translator Application',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslationPage(),
    );
  }
}
 