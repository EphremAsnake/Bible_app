import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../model/bible/book.dart';
import '../model/bible/verses.dart';
import '../services/database_service.dart';
import '../utils/api_state_handler.dart';
import '../utils/keys.dart';
import '../utils/storagepreference.dart';

class DataGetterAndSetter extends GetxController {
  int selectedIndex = -1;
  int selectedOldTestamentBookIndex = -1;
  int selectedNewTestamentBookIndex = -1;
  final cacheStateHandler = ApiStateHandler<List<Book>>();
  List<Book> oldTestamentBook = [];
  List<Book> newTestamentBook = [];
  List<Verses> versesAMH = [];
  List<Verses> selectedVersesAMH = [];
  List<Verses> verseAMHListForBook = [];

  List<String> otherLanguageOT = [];
  List<String> otherLanguageNT = [];
  List<String> otherLanguageAllChapters = [];

  getAMHBookChapters(
    int book,
    int chapter,
    List<Verses> versesAMH,
  ) {
    List<Verses> verseAMHForBook = versesAMH
        .where((element) => element.book == book && element.chapter == chapter)
        .toList();
    List<Verses> verseTitle = versesAMH
        .where(
            (element) => element.book == book && element.chapter == chapter - 1)
        .toList();
    List<Verses> verseAMHListForBookList = [...verseAMHForBook, ...verseTitle];
    verseAMHListForBook.addAll(verseAMHListForBookList);
    return verseAMHListForBook;
  }

  getNextBookChapter(
    int book,
    int chapter,
    int index,
  ) {
    Verses nextVerseForBook = selectedVersesAMH[index + 1];
    return nextVerseForBook;
  }

  getPreviousBookChapter(
    int book,
    int chapter,
    int index,
  ) {
    Verses previousVerseForBook = selectedVersesAMH[index - 1];
    return previousVerseForBook;
  }

  List<List<Verses>> groupedBookList() {
    //versesAMH.removeWhere((e) => e.para == "mt1");

    var groupedVerses =
        groupBy(versesAMH, (Verses verse) => '${verse.book}-${verse.chapter}');

    List<List<Verses>> groupedVerseList = [];

    groupedVerses.forEach((key, versesList) {
      // Sort the verses within the group based on verse number
      versesList.sort((a, b) => a.verseNumber!.compareTo(b.verseNumber!));

      // Merge verses with the same verse number within the same chapter
      List<Verses> mergedVerses = [];
      int currentChapter = -1;
      int currentVerseNumber = -1;

      for (var verse in versesList) {
        //if (verse.para != "s1") {
        if (verse.chapter != currentChapter ||
            verse.verseNumber != currentVerseNumber) {
          // Add the verse if it's a new chapter or verse number

          mergedVerses.add(verse);
          currentChapter = verse.chapter!;
          currentVerseNumber = verse.verseNumber!;
        } else {
          // Merge verses with the same verse number within the same chapter
          mergedVerses.last.verseText =
              (mergedVerses.last.verseText ?? '').trim() +
                  (verse.verseText ?? '').trim();
        }
        // }
        //  else {
        //   mergedVerses.add(verse);
        // }
      }

      groupedVerseList.add(mergedVerses);
    });

    return groupedVerseList;
  }

  Future<void> readData() async {
    cacheStateHandler.setLoading();
    await DatabaseService().copyDatabaseBooks();
    await DatabaseService().copyDatabaseEng();
    await DatabaseService().copyDatabaseOtherLanguage();
    List<Book> books = await DatabaseService().readBookDatabase();
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String selectedBook = "";
    String? bookName =
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      if (bookName == "English KJV") {
        selectedBook = bookName;
      }
      var amh = await DatabaseService().readVersesDatabase(selectedBook);
      versesAMH.addAll(amh);

      try {
        //default iterating over the list of bible index 0 nd version index of 0
        for (int k = 0; k < books.length; k++) {
          if (books[k].testament == "OT") {
            oldTestamentBook.add(books[k]);
          } else if (books[k].testament == "NT") {
            newTestamentBook.add(books[k]);
          }
        }
        cacheStateHandler.setSuccess(books);
        update();
      } catch (ex) {
        //! Update state with error message
        // String errorMessage = await HandleHttpException().getExceptionString(ex);
        // cacheStateHandler.setError(errorMessage);
        update();
      }
    }
  }
}
