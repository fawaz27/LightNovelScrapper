import 'package:flutter/material.dart';
import 'package:lnscraper/src/models/novel.dart';
import 'dart:io';
class NovelCard extends StatelessWidget {
  final Novel novel;

  const NovelCard({super.key, required this.novel});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Stack(fit: StackFit.expand, children: [
        Image.file(
          File(novel.coverImage),
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: const Color(0xAA434343),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      novel.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
