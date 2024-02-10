import 'package:flutter/material.dart';
import 'package:lnscraper/src/model/novel.dart';
import 'dart:io';

import 'package:lnscraper/src/utils/screen_sizes.dart';

class NovelInfoScreen extends StatelessWidget {
  const NovelInfoScreen({Key? key, required this.novel}) : super(key: key);

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novel.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: ScreenSizes.isDesktop(context) ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    Image.file(
                      File(novel.coverImage),
                      fit: BoxFit.contain,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          novel.name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Author: ${novel.author}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description: ${novel.description}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${novel.status}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Source: ${novel.source}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: ScreenSizes.isDesktop(context)
                    ? const EdgeInsets.all(40.0)
                    : const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: novel.chapters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(novel.chapters[index]),
                            // Ajoutez ici les actions pour chaque chapitre
                          ),
                          Divider(
                            thickness: 1,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
