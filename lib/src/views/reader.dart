import 'package:flutter/material.dart';
import 'package:lnscraper/src/models/chapter.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({Key? key, required this.chapter}) : super(key: key);
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            chapter.content,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
