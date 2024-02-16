import 'package:flutter/material.dart';
import 'package:lnscraper/src/model/chapter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:lnscraper/src/screens/novel_info.dart';
import 'package:lnscraper/src/utils/screen_sizes.dart';
import 'package:lnscraper/src/widgets/search_widget.dart';
import 'package:lnscraper/src/model/novel.dart';
import 'package:lnscraper/src/widgets/novel_card.dart';
import 'package:path/path.dart';
int compareChapters(Chapter a, Chapter b) {
  return a.title.compareTo(b.title);
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isSearchInputVisible = false;
  List<Novel> novels = [];

  void toggleSearchVisibility(bool visibility) {
    setState(() {
      _isSearchInputVisible = visibility;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNovels('download');
  }

  Future<void> _loadNovels(String directoryPath) async {
    // Chemin du répertoire contenant les romans
    Directory novelsDirectory = Directory(directoryPath);

    if (await novelsDirectory.exists()) {
      List<Novel> loadedNovels = [];
      List<FileSystemEntity> sourceDirectories =
          await novelsDirectory.list().toList();
      for (FileSystemEntity sourceDirectory in sourceDirectories) {
        if (sourceDirectory is Directory) {
          List<FileSystemEntity> novelDirectories =
              await sourceDirectory.list().toList();
          for (FileSystemEntity novelDirectory in novelDirectories) {
            if (novelDirectory is Directory) {
              File metadataFile = File('${novelDirectory.path}/metadata.json');
              if (await metadataFile.exists()) {
                String metadataJson = await metadataFile.readAsString();
                Map<String, dynamic> metadata =
                    jsonDecode(metadataJson) as Map<String, dynamic>;

                // Charger les chapitres du roman
                List<Chapter> chapters = [];

                // Vérifier si le répertoire des chapitres existe
                Directory chapterDirectory =
                    Directory('${novelDirectory.path}/chapters');
                if (await chapterDirectory.exists()) {
                  // Liste des fichiers de chapitre
                  List<FileSystemEntity> chapterFiles =
                      await chapterDirectory.list().toList();
                  for (FileSystemEntity chapterFile in chapterFiles) {
                    if (chapterFile is File) {
                      String chapterContent = await chapterFile.readAsString();
                      chapters.add(Chapter(
                        title: basenameWithoutExtension(chapterFile.path), // Utilisez le nom du fichier comme titre du chapitre
                        content: chapterContent,
                      ));
                    }
                  }
                  chapters.sort(compareChapters);
                }
                loadedNovels.add(Novel(
                  name: metadata['name'],
                  coverImage: '${novelDirectory.path}/cover.jpg',
                  author: metadata['author'],
                  description: metadata['description'],
                  status: metadata['status'],
                  source: metadata['source'],
                  chapters: chapters,
                ));
              }
            }
          }
        }
      }

      setState(() {
        novels = loadedNovels;
      });
    }
  }

  void reloadNovels() {
    setState(() {
      novels = [];
    });
    _loadNovels('download');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Library',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: ScreenSizes.isMobile(context)
                    ? [
                        SearchWidget(
                          isVisible: _isSearchInputVisible,
                          onVisibilityChanged: toggleSearchVisibility,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {
                            toggleSearchVisibility(false);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: reloadNovels,
                        ),
                      ]
                    : [
                        SizedBox(
                          width:
                              ScreenSizes.calculateWidthPercentage(context, 55),
                        ),
                        SearchWidget(
                          isVisible: true,
                          onVisibilityChanged: (visible) {},
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: reloadNovels,
                        ),
                      ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenSizes.isDesktop(context)
                          ? 7
                          : (ScreenSizes.isTablet(context) ? 4 : 2),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      // childAspectRatio: ScreenSizes.getGridItemAspectRatio(context),
                      mainAxisExtent: 270),
                  itemCount: novels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    NovelInfoScreen(novel: novels[index]))))),
                        child: NovelCard(novel: novels[index]));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
