// src/screens/history.dart
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple.shade500,
      alignment: Alignment.center,
      child: const Text(
        'History',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
