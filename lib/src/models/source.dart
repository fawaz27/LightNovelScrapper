import 'package:lnscraper/src/models/novel.dart';

class Source {
  final String name;
  final String url;
  final List<Novel> novels;

  Source({required this.name, required this.url, required this.novels});

  int getTotalNovels() {
    return 0;
  }
}
