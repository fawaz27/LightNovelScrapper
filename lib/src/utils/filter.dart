import 'package:lnscraper/src/models/chapter.dart';

int compareChapters(Chapter a, Chapter b) {
  return a.title.compareTo(b.title);
}