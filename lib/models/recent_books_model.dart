import 'package:objectbox/objectbox.dart';

@Entity()
class RecentBooks {
  @Id()
  int id;
 final String bookName;
 final  String bookId;
 final String bookImageId;

  RecentBooks({required this.bookName, required this.bookId,required  this.bookImageId, this.id = 0});
}
