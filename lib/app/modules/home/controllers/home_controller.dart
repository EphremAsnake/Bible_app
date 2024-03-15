import 'dart:convert';
import 'dart:io';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/core/shared_controllers/master_data_http_attribuites.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = -1;
  int selectedOldTestamentBookIndex = -1;
  int selectedNewTestamentBookIndex = -1;
  final cacheStateHandler = ApiStateHandler<List<Book>>();
  var httpService = Get.find<HttpService>();
  List<Book> oldTestamentBook = [];
  List<Book> newTestamentBook = [];
  String selectedTestament = "OT";
  List<Verses> versesAMH = [];
  List<Verses> selectedVersesAMH = [];
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  void updateOldTestamentSelectedBookIndex(int index) {
    selectedOldTestamentBookIndex = index;
    selectedNewTestamentBookIndex = -1;
    final DetailController detailController = Get.find<DetailController>();
    if (detailController.drawerScrollController.hasClients) {
      detailController.drawerScrollController.animateTo(
        0.0, // Scroll to the top
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Use a different curve if desired
      );
    }
    selectedIndex = -1;
    detailController.isSelectingBook = false;
    detailController.update();
    update();
  }

  void updateNewTestamentSelectedBookIndex(int index) {
    selectedNewTestamentBookIndex = index;
    selectedOldTestamentBookIndex = -1;
    final DetailController detailController = Get.find<DetailController>();
    if (detailController.drawerScrollController.hasClients) {
      detailController.drawerScrollController.animateTo(
        0.0, // Scroll to the top
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Use a different curve if desired
      );
    }
    selectedIndex = -1;
    detailController.isSelectingBook = false;
    detailController.update();
    update();
  }

  void setSelectedBookAndChapterForDrawer(
      int bookId, int chapterNumber, String testament) {
    if (testament == "OT") {
      selectedOldTestamentBookIndex = bookId - 1;
      selectedIndex = chapterNumber - 1;
      selectedTestament = testament;
      update();
    } else if (testament == "NT") {
      selectedNewTestamentBookIndex = 26 - (66 - bookId);
      selectedIndex = chapterNumber - 1;
      selectedTestament = testament;
      update();
    }
  }

  Future<void> updateJsonFile() async {
    try {
      dynamic response =
          await httpService.sendHttpRequest(MasterDataHttpAttributes());

      if (response.statusCode == 200) {
        // Decode the JSON response
        final jsonData = jsonDecode(response.body);

        // Convert the JSON data to a string
        final jsonString = jsonEncode(jsonData);
        // Write the JSON string to the asset file
        await writeJsonToFile(jsonString);
      } else {}
    } catch (ex) {
      HandleHttpException().getExceptionString(ex);
    }
  }

  Future<void> writeJsonToFile(String jsonString) async {
    final file = File('assets/bible_list.json');
    await file.writeAsString(jsonString);
  }

  Future<void> readBibleData() async {
    cacheStateHandler.setLoading();
    await DatabaseService().copyDatabase();
    List<Book> books = await DatabaseService().readBookDatabase();
    var amh = await DatabaseService().readVersesDatabase("AMHKJV");
    await getterAndSetterController.readData();
    versesAMH.addAll(amh);

    try {
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
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      cacheStateHandler.setError(errorMessage);
      update();
    }
  }
}
