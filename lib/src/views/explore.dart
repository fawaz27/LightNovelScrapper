// src/screens/explore.dart
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade500,
      alignment: Alignment.center,
      child: const Text(
        'Explore',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
