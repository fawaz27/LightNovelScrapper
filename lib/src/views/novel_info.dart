import 'package:flutter/material.dart';
import 'package:lnscraper/src/models/novel.dart';
import 'package:lnscraper/src/views/reader.dart';
import 'dart:io';
import 'package:lnscraper/src/utils/screen_sizes.dart';
import 'package:readmore/readmore.dart';

class NovelInfoScreen extends StatelessWidget {
  const NovelInfoScreen({Key? key, required this.novel}) : super(key: key);

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novel.name),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              height: 400,
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenSizes.isDesktop(context)
                        ? 200
                        : ScreenSizes.isTablet(context)
                            ? 60
                            : 0,
                  ),
                  Image.file(
                    File(novel.coverImage),
                    // fit: BoxFit.contain,
                    height: !ScreenSizes.isDesktop(context)
                        ? ScreenSizes.isMobile(context)
                            ? 220
                            : 300
                        : double.infinity,
                    // width: double.infinity,
                  ),
                  SizedBox(
                    width: ScreenSizes.isDesktop(context)
                        ? 100
                        : ScreenSizes.isTablet(context)
                            ? 20
                            : 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenSizes.isDesktop(context) ? 0 : 25,
                      ),
                      Text(
                        novel.name,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Author: ${novel.author}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
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
                      const Text(
                        'Description ',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 160,
                        width: ScreenSizes.isMobile(context)
                            ? 240
                            : ScreenSizes.isTablet(context)
                                ? 320
                                : 400,
                        child: ReadMoreText(
                          novel.description,
                          trimLines: 2,
                          colorClickableText: const Color(0xFF5F67EA),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Plus',
                          trimExpandedText: 'Réduire',
                          style: const TextStyle(height: 1.5),
                        ),
                      )
                    ],
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: ScreenSizes.isDesktop(context)
                  ? const EdgeInsets.all(40.0)
                  : const EdgeInsets.all(20.0),
              child: novel.chapters.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No chapters available!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: novel.chapters.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReaderScreen(
                              chapter: novel.chapters[index],
                            ),
                          )),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(novel.chapters[index].title),
                              ),
                              const Divider(
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
    );
  }
}
