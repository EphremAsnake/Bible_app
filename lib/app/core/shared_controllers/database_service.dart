import 'dart:io';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/devotion.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<void> copyDatabase() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Check if the database file already exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Create the parent directory if it doesn't exist
      await Directory(dirname(path)).create(recursive: true);

      // Copy the database file from assets to the device
      ByteData data = await rootBundle.load('assets/db/bible.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Book>> readBookDatabase() async {
    List<Book> books = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM books');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final book = Book(
        chapters: row["chapters"],
        id: row["_id"],
        name: row["name"],
        nameGeez: row["nameGeez"],
        testament: row["testament"],
        title: row["title"],
        titleGeez: row["titleGeez"],
        titleGeezShort: row["titleGeezShort"],
      );

      books.add(book);
    }

    // Close the database
    await database.close();

    //return result
    return books;
  }

  Future<List<Verses>> readVersesDatabase(String book) async {
    List<Verses> versesAMH = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM $book');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verseAMH = Verses(
        book: row["book"],
        chapter: row["chapter"],
        para: row["para"],
        highlight: row["highlight"],
        verseNumber: row["verseNumber"],
        verseText: row["verseText"],
      );

      versesAMH.add(verseAMH);
    }

    // Close the database
    await database.close();

    //return result
    return versesAMH;
  }

  Future<String> readVersesfromDB(
      String book, int chapter, int verseNumber, int booknum) async {
    List<Verses> versesSelected = [];
    String thisverse = '';
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows = await database.rawQuery(book ==
                "AMHNIV" ||
            book == "ENGNIV"
        ? 'SELECT * FROM $book WHERE chapter = $chapter AND verseNumber = $verseNumber AND book = $booknum AND para NOT IN ("s1", "s2", "s3", "d")'
        : 'SELECT * FROM $book WHERE chapter = $chapter AND verseNumber = $verseNumber AND book = $booknum');
    // Logger logger = Logger();
    // logger.e(rows);
    //thisverse = rows;
    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final selectedverse = Verses(
        book: row["book"],
        chapter: row["chapter"],
        para: row["para"],
        highlight: row["highlight"],
        verseNumber: row["verseNumber"],
        verseText: row["verseText"],
      );
      // thisverse = rows[''];

      versesSelected.add(selectedverse);
    }
    if (versesSelected.isNotEmpty) {
      thisverse = versesSelected
          .map((verse) => (verse.verseText ?? '').trim())
          .join(' ');
    }

    //thisverse = versesSelected[0].verseText ?? '';
    // Close the database
    await database.close();

    //return result
    return thisverse;
  }

  Future<List<Verses>> changeBibleType(String type) async {
    List<Verses> verses = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM $type');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verseNIV = Verses(
        book: row["book"],
        chapter: row["chapter"],
        para: row["para"],
        highlight: row["highlight"],
        verseNumber: row["verseNumber"],
        verseText: row["verseText"],
      );

      verses.add(verseNIV);
    }

    // Close the database
    await database.close();

    //return result
    return verses;
  }

  Future<void> updateHighlight(int book, int chapter, int verseNumber,
      int newHighlight, String tableName) async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);
    if (tableName == 'አማርኛ 1954') {
      tableName = "AMHKJV";
    } else if (tableName == 'አዲሱ መደበኛ ትርጉም') {
      tableName = "AMHNIV";
    } else if (tableName == 'English NIV') {
      tableName = "ENGNIV";
    } else if (tableName == 'English KJV') {
      tableName = "ENGKJV";
    }
    await database.update(
      tableName,
      {'highlight': newHighlight},
      where: 'book = ? AND chapter = ? AND verseNumber = ?',
      whereArgs: [book, chapter, verseNumber],
    );
    await database.close();
  }

  Future<List<Devotion>> readDevotionTable() async {
    List<Devotion> devotions = [];

    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.db');

    // Open the database
    Database database = await openDatabase(path);

    try {
      // Query the database
      List<Map<String, dynamic>> rows =
          await database.rawQuery('SELECT * FROM AMH_Devotion');

      // Process the retrieved data
      for (Map<String, dynamic> row in rows) {
        final devotion = Devotion(
          id: row["id"],
          date: row["date"],
          verse: row["verse"],
          verseLocation: row["verseLocation"],
          verseDescription: row["verseDescription"],
          versePrayer: row["versePrayer"],
        );

        devotions.add(devotion);
      }
    } finally {
      if (database.isOpen) {
        await database.close();
      }
    }

    return devotions;
  }
}
