import 'package:flutter/material.dart';
import 'package:lnscraper/src/entity/novel.dart';

class NovelCard extends StatelessWidget {
  final Novel novel;

  const NovelCard({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(
              novel.imageUrl,
              fit: BoxFit.fill,
              
            ),
          ),
          // Text(
          //   novel.name,
          //   style: TextStyle(
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
