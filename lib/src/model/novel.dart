import 'package:lnscraper/src/model/chapter.dart';

class Novel {
  final String name;
  final String coverImage;
  final String author;
  final String description;
  final String status;
  final String source;
  final List<Chapter> chapters;
  Novel({
    required this.name,
    required this.coverImage,
    required this.author,
    required this.description,
    required this.status,
    required this.source,
    required this.chapters,
  });
}
