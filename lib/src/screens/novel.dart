import 'package:flutter/material.dart';
import 'package:lnscraper/src/model/novel.dart';

class NovelScreen extends StatelessWidget {
  const NovelScreen({super.key, required this.novel});
  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novel.name),
      ),
    );
  }
}
