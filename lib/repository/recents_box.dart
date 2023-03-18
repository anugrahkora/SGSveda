import 'package:get/get.dart';

import '../models/recent_books_model.dart';
import '../objectbox.g.dart';

class RecentsBox {
  late final Store _store;
  late final Box<RecentBooks> _recentBox;

  RecentsBox._init(this._store) {
    _recentBox = Box<RecentBooks>(_store);
  }
  static Future<RecentsBox> init() async {
    final store = await openStore();
    return RecentsBox._init(store);
  }

  close() {
    _store.close();
  }

  RecentBooks? getBook(int id) => _recentBox.get(id);
  List<RecentBooks>? getAllBooks() => _recentBox.getAll();

  addBook(RecentBooks newBook) {
    final allBooks = getAllBooks();
    if ((allBooks!.firstWhereOrNull(
          (book) => book.bookId == newBook.bookId,
        )) !=
        null) {
      // print('Already exists!');
    } else {
      return _recentBox.put(newBook);
    }
  }

  int getBooksCount() => _recentBox.getAll().length;

  bool deleteBook(int id) => _recentBox.remove(id);
  int deleteAllBooks() => _recentBox.removeAll();
}
