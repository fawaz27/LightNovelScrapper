import 'package:flutter/material.dart';
import 'package:lnscraper/src/utils/filter.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';
import 'package:lnscraper/src/models/source.dart';
import 'package:lnscraper/src/models/novel.dart';
import 'package:lnscraper/src/models/chapter.dart';

class LibraryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String path;
  List<Source> _sources = [];
  LibraryViewModel({required this.path});

  List<Source> get sources => _sources;
  bool get isLoading => _isLoading;

  Future<void> loadNovels() async {
    try {
      // Chemin du répertoire contenant les romans
      _isLoading = true;
      notifyListeners();
      Directory sourcesDirectory = Directory(path);
      if (await sourcesDirectory.exists()) {
        List<Source> loadedSources = [];
        List<FileSystemEntity> sourceDirectories =
            await sourcesDirectory.list().toList();
        for (FileSystemEntity sourceDirectory in sourceDirectories) {
          if (sourceDirectory is Directory) {
            List<FileSystemEntity> novelDirectories =
                await sourceDirectory.list().toList();
            List<Novel> novels = [];

            // Parcourir les répertoires de romans
            for (FileSystemEntity novelDirectory in novelDirectories) {
              if (novelDirectory is Directory) {
                File metadataFile =
                    File('${novelDirectory.path}/metadata.json');
                if (await metadataFile.exists()) {
                  String metadataJson = await metadataFile.readAsString();
                  Map<String, dynamic> metadata =
                      jsonDecode(metadataJson) as Map<String, dynamic>;
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
                        String chapterContent =
                            await chapterFile.readAsString();
                        chapters.add(Chapter(
                          title: basenameWithoutExtension(chapterFile.path),
                          content: chapterContent,
                        ));
                      }
                    }
                    chapters.sort(compareChapters);
                  }
                  Novel novel = Novel(
                    name: metadata['name'],
                    coverImage: '${novelDirectory.path}/cover.jpg',
                    author: metadata['author'],
                    description: metadata['description'],
                    status: metadata['status'],
                    source: metadata['source'],
                    chapters: chapters,
                  );
                  novels.add(novel);
                }
              }
            }
            loadedSources.add(Source(
              name: sourceDirectory.path.split('/').last,
              url: '',
              novels: novels,
            ));
          }
        }

        _sources = loadedSources;
        _isLoading = false;
  
        notifyListeners();
      }
    } catch (e) {
      // Gérer les erreurs ici
      print('Error loading novels: $e');
    }
  }

  void addNovel() {}
  void removeNovel() {}
}
