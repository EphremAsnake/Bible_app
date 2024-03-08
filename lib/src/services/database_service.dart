import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/utils/Strings.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../controller/datagetterandsetter.dart';
import '../model/bible/book.dart';
import '../model/bible/devotion.dart';
import '../model/bible/verses.dart';

class DatabaseService {
  Future<void> copyDatabaseBooks() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'books.db');

    // Check if the database file already exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Create the parent directory if it doesn't exist
      await Directory(dirname(path)).create(recursive: true);

      // Copy the database file from assets to the device
      ByteData data = await rootBundle.load('assets/db/books.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<void> copyDatabaseEng() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'kjv.db');

    // Check if the database file already exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Create the parent directory if it doesn't exist
      await Directory(dirname(path)).create(recursive: true);

      // Copy the database file from assets to the device
      ByteData data = await rootBundle.load('assets/db/kjv.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<void> copyDatabaseOtherLanguage() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, Strings.otherbibledatabase);

    // Check if the database file already exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Create the parent directory if it doesn't exist
      await Directory(dirname(path)).create(recursive: true);

      // Copy the database file from assets to the device
      ByteData data =
          await rootBundle.load('assets/db/${Strings.otherbibledatabase}');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Book>> readBookDatabase() async {
    List<Book> books = [];
    Database? database = null;
    Logger logger = Logger();
    try {
      // Get the path to the database file
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'books.db');

      // Open the database
      database = await openDatabase(path);

      // Query the database
      List<Map<String, dynamic>> rows =
          await database.rawQuery('SELECT * FROM books');

      // Process the retrieved data
      logger.e('Rows Returned: $rows');
      for (Map<String, dynamic> row in rows) {
        final book = Book(
          chapters: row["chapters"],
          id: row["_id"],
          name: row["name"],
          testament: row["testament"],
          title: row["title"],
        );

        books.add(book);
      }
    } catch (e) {
      logger.e('Error reading database: $e');
      // Handle the error gracefully, e.g., return an empty list or show an error message
    } finally {
      if (database != null) {
        logger.e('Database Closed Successfully');
        await database.close();
      }
    }

    //return result
    return books;
  }

  Future<List<Verses>> readVersesDatabase(String book) async {
    List<Verses> versesAMH = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,
        book == "English KJV" ? 'kjv.db' : Strings.otherbibledatabase);

    // Open the database
    Database database = await openDatabase(path);

    // await database.execute('ALTER TABLE words ADD COLUMN highlight INTEGER DEFAULT 0;');

    // Check if the 'highlight' column already exists in the 'words' table
    bool columnExists = false;
    List<Map<String, dynamic>> columns =
        await database.rawQuery("PRAGMA table_info(words);");
    for (Map<String, dynamic> column in columns) {
      if (column['name'] == 'highlight') {
        columnExists = true;
        break;
      }
    }

    // Add the 'highlight' column if it doesn't exist
    if (!columnExists) {
      await database
          .execute('ALTER TABLE words ADD COLUMN highlight INTEGER DEFAULT 0;');
    }
    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM words');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verseAMH = Verses(
        book: row["bookNum"],
        chapter: row["chNum"],
        highlight: row["highlight"] ?? 0,
        verseNumber: row["verseNum"],
        verseText: row["word"],
      );

      versesAMH.add(verseAMH);
    }

    // Close the database
    await database.close();

    //return result
    return versesAMH;
  }

  Future<List<Verses>> changeBibleType(String type) async {
    List<Verses> verses = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,
        type == "English KJV" ? 'kjv.db' : Strings.otherbibledatabase);

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM words');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verse = Verses(
        book: row["bookNum"],
        chapter: row["chNum"],
        highlight: row["highlight"] ?? 0,
        verseNumber: row["verseNum"],
        verseText: row["word"],
      );

      verses.add(verse);
    }

    // Close the database
    await database.close();

    //return result
    return verses;
  }

  Future<void> updateHighlight(int book, int chapter, int verseNumber,
      int newHighlight, String bibleName) async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,
        bibleName == "English KJV" ? 'kjv.db' : Strings.otherbibledatabase);

    // Open the database
    Database database = await openDatabase(path);
    // if (tableName == 'አማርኛ 1954') {
    //   tableName = "AMHKJV";
    // } else if (tableName == 'አዲሱ መደበኛ ትርጉም') {
    //   tableName = "AMHNIV";
    // } else if (tableName == 'English NIV') {
    //   tableName = "ENGNIV";
    // } else if (tableName == 'English KJV') {
    //   tableName = "ENGKJV";
    // }
    await database.update(
      'words',
      {'highlight': newHighlight},
      where: 'bookNum = ? AND chNum = ? AND verseNum = ?',
      whereArgs: [book, chapter, verseNumber],
    );
    await database.close();
  }

//   Future<void> updateHighlight(int book, int chapter, int verseNumber,
//       int newHighlight, String bibleName) async {
//     // Get the path to the database file
//     String databasesPath = await getDatabasesPath();
//     String path = join(databasesPath,
//         bibleName == "English KJV" ? 'kjv.db' : Strings.otherbibledatabase);

//     // Open the database
//     Database database = await openDatabase(path, onCreate: (db, version) async {
//       // Create the 'words' table if it doesn't exist
//       await db.execute('''
//         CREATE TABLE IF NOT EXISTS words (
//           id INTEGER PRIMARY KEY,
//           bookNum INTEGER,
//           chNum INTEGER,
//           verseNum INTEGER,
//           highlight INTEGER
//         )
//       ''');
//     }, version: 2);

//     // Update the highlight
//     await database.update(
//       'words',
//       {'highlight': newHighlight},
//       where: 'bookNum = ? AND chNum = ? AND verseNum = ?',
//       whereArgs: [book, chapter, verseNumber],
//     );
//     await database.close();
// }

  // Future<void> readBookConfigurationofOtherLanguage() async {
  //   // Get the path to the database file
  //   String databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, Strings.otherbibledatabase);

  //   // Open the database
  //   Database database = await openDatabase(path);

  //   List<Map<String, dynamic>> tables =
  //       await database.rawQuery("select booknames from configuration");
  //   // Print all table names
  //   for (Map<String, dynamic> table in tables) {
  //     Logger logger = Logger();

  //     logger.e("Table name spaniop: ${table}");
  //   }
  //   // Query the database
  //   List<Map<String, dynamic>> rows =
  //       await database.rawQuery('SELECT * FROM words');

  //   print(rows[0]);

  //   await database.close();
  // }
  Future<void> readBookConfigurationofOtherLanguage() async {
    final DataGetterAndSetter dataController = Get.find();
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, Strings.otherbibledatabase);

    // Open the database
    Database database = await openDatabase(path);

    List<Map<String, dynamic>> tables =
        await database.rawQuery("select booknames from configuration");

    // Extract the book names from the first row
    String bookNames = tables[0]['booknames'];

    bookNames = bookNames.replaceAll('"', '');

    // Split the book names into a list
    List<String> books = bookNames.split(' , ');

    // Separate the books into Old Testament and New Testament
    dataController.otherLanguageOT = books.sublist(0, 39);
    dataController.otherLanguageNT = books.sublist(39);
    dataController.otherLanguageAllChapters = books;

    // Print or store the separated lists
    // print('Old Testament: $oldTestament');
    // print('New Testament: $newTestament');

    await database.close();
  }

  // Future<List<Devotion>> readDevotionTable() async {
  //   List<Devotion> devotions = [];

  //   // Get the path to the database file
  //   String databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, 'bible.db');

  //   // Open the database
  //   Database database = await openDatabase(path);

  //   try {
  //     // Query the database
  //     List<Map<String, dynamic>> rows =
  //         await database.rawQuery('SELECT * FROM AMH_Devotion');

  //     // Process the retrieved data
  //     for (Map<String, dynamic> row in rows) {
  //       final devotion = Devotion(
  //         id: row["id"],
  //         date: row["date"],
  //         verse: row["verse"],
  //         verseLocation: row["verseLocation"],
  //         verseDescription: row["verseDescription"],
  //         versePrayer: row["versePrayer"],
  //       );

  //       devotions.add(devotion);
  //     }
  //   } finally {
  //     if (database.isOpen) {
  //       await database.close();
  //     }
  //   }

  //   return devotions;
  // }
}
