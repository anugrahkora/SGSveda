import 'package:objectbox/objectbox.dart';

@Entity()
class DownloadedBooks {
  @Id()
  int id;
  final String bookName;
  final String subCategoryName;
  final String chapterName;
  final String chapterId;
  final String bookId;
  final String subCategoryId;

  final String bookImageId;

  DownloadedBooks(this.subCategoryName, this.subCategoryId, this.chapterName, this.chapterId,
      {required this.bookName,
      required this.bookId,
      required this.bookImageId,
      this.id = 0});
}
