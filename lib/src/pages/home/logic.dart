import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/utils/Strings.dart';

import '../../controller/datagetterandsetter.dart';
import '../../model/bible/book.dart';
import '../../model/bible/verses.dart';
import '../../model/configs/configs.dart';
import '../../services/database_service.dart';
import '../../utils/api_state_handler.dart';
import '../../utils/storagepreference.dart';

class HomePageController extends GetxController {
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController drawerScrollController = ScrollController();
  ScrollController readerScrollController = ScrollController();
  final apiStateHandler = ApiStateHandler<Configs>();
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  List<Verses> searchResultVerses = [];
  String selectedSearchTypeOptions = 'every_word'.tr;
  String selectedSearchPlaceOptions = 'all'.tr;

  String selectedBook = 'English KJV';
  double fontSize = 12.5;
  bool isLoading = false;
  int defaultTabBarViewInitialIndex = 0;
  bool isSelectingBook = false;
  List<List<Verses>> allVerses = [];
  PageController? pageController;
  String drawerQuote = "";
  Verses? selectedVerse;
  bool callbackExecuted = false;
  int selectedRowIndex = -1;
  bool hidePageNavigators = false;
  List<Book> booksList = [];
  List<Book> booksListOtherLanguage = [];
  int previousOpenedBookPageNumber = 0;
  String selectedBookTypeOptions = Strings.bibletitle;
  List<Book> books = [];
  List<String> bookTypeOptions = [Strings.bibletitle, 'English KJV'];
  List<String> searchTypeOptions = [
    'every_word'.tr,
    'exactly'.tr,
  ];
  @override
  void onInit() {
    super.onInit();

    loadData();
    getPreviousPageNumber();
    allVerses.addAll(getterAndSetterController.groupedBookList());
    setInitialSelectedBookTypeOptions();
    getBooks();
    loadInitialPage();
    //fetchConfigsData();
    getFontSize();
  }

  setSelectedSearchTypeOptions(String newValue) {
    selectedSearchTypeOptions = newValue;
    update();
  }

  setSelectedSearchPlaceOptions(String newValue) {
    selectedSearchPlaceOptions = newValue;
    update();
  }

  List<String> searchPlaceOptions = [
    'ot'.tr,
    'nt'.tr,
    'all'.tr,
  ];
  clearSearchBar() {
    searchController.clear();
    searchResultVerses.clear();
    update();
  }

  Future<List<Verses>> search({
    required String bibleType,
    required String searchType,
    required String searchPlace,
    required String query,
  }) async {
    isLoading = true;
    update();
    List<Verses> emptyVerses = [];
    if (query.length < 2) {
      isLoading = false;
      update();
      return emptyVerses;
    }
    if (searchType == 'every_word'.tr) {
      if (searchPlace == 'ot'.tr) {
        isLoading = false;
        update();
        return await handleSearch("OT", query, 'contains', bibleType);
      } else if (searchPlace == 'nt'.tr) {
        isLoading = false;
        update();
        return await handleSearch("NT", query, 'contains', bibleType);
      } else if (searchPlace == 'all'.tr) {
        isLoading = false;
        update();
        return await handleSearch("", query, 'contains', bibleType);
      } else {
        isLoading = false;
        update();
        return emptyVerses;
      }
    } else if (searchType == 'exactly'.tr) {
      if (searchPlace == 'ot'.tr) {
        isLoading = false;
        update();
        return await handleSearch("OT", query, 'exact', bibleType);
      } else if (searchPlace == 'nt'.tr) {
        isLoading = false;
        update();
        return await handleSearch("NT", query, 'exact', bibleType);
      } else if (searchPlace == 'all'.tr) {
        isLoading = false;
        update();
        return await handleSearch("", query, 'exact', bibleType);
      } else {
        isLoading = false;
        update();
        return emptyVerses;
      }
    } else {
      isLoading = false;
      update();
      return emptyVerses;
    }
  }

  Future<List<Verses>> handleSearch(
    String testament,
    String query,
    String searchOption,
    String bibleType,
  ) async {
    if (bibleType == 'English KJV') {
      bibleType = "English KJV";
    } else {
      bibleType = Strings.bibletitle;
    }
    List<Verses> verses = await DatabaseService().changeBibleType(bibleType);
    List<Book> oldTestamentBookIDs = [];
    List<Verses> oldTestamentBookVerses = [];
    books = await DatabaseService().readBookDatabase();

    if (testament != "") {
      oldTestamentBookIDs =
          books.where((element) => element.testament == testament).toList();
    } else {
      oldTestamentBookIDs = books;
    }
    for (int i = 0; i < oldTestamentBookIDs.length; i++) {
      //check
      List<Verses> oldTestamentBookVerseTemp = verses
          .where((element) => element.book == oldTestamentBookIDs[i].id)
          .toList();
      oldTestamentBookVerses.addAll(oldTestamentBookVerseTemp);
    }
    if (searchOption == "contains") {
      oldTestamentBookVerses = oldTestamentBookVerses
          .where((verse) => verse.verseText!.contains(query))
          .toList();
      if (oldTestamentBookVerses.isNotEmpty) {
        await changeBibleFromSearch(bibleType);
      }
      return oldTestamentBookVerses;
    } else if (searchOption == 'exact') {
      List<Verses> searchResults = [];
      for (Verses item in oldTestamentBookVerses) {
        List<String> words = item.verseText!.split(" ");
        if (words.contains(query)) {
          searchResults.add(item);
        }
      }
      if (searchResults.isNotEmpty) {
        await changeBibleFromSearch(bibleType);
      }
      return searchResults;
    } else {
      List<Verses> emptyVerses = [];
      return emptyVerses;
    }
  }

  saveLocale(String locale) async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveStringData(Strings.selectedLocale, locale);
  }

  changeBibleFromSearch(String bibleType) async {
    String saveName = "";
    if (bibleType == 'ENGKJV') {
      saveName = "English KJV";
    } else {
      saveName = Strings.bibletitle;
    }
    //changing book type
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    getterAndSetterController.versesAMH =
        await DatabaseService().changeBibleType(bibleType);
    getterAndSetterController.update();
    allVerses.assignAll(getterAndSetterController.groupedBookList());
    //saving selected book to local storage
    sharedPreferencesStorage.saveStringData(Strings.selectedBookKey, saveName);
    //set selected book Name
    setSelectedBook(saveName);
    update();
  }

  Future<void> loadInitialData() async {
    final HomePageController controller = Get.find<HomePageController>();
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Strings.selectedBookKey);

    await EasyLoading.show(status: '...');

    controller.isLoading = true;
    controller.update();
    // SharedPreferencesStorage sharedPreferencesStorage =
    //     SharedPreferencesStorage();
    getterAndSetterController.versesAMH =
        await DatabaseService().changeBibleType(bookName ?? Strings.bibletitle);
    getterAndSetterController.update();
    controller.allVerses.assignAll(getterAndSetterController.groupedBookList());

    //saving selected book to local storage
    sharedPreferencesStorage.saveStringData(
        Strings.selectedBookKey, bookName ?? Strings.bibletitle);
    //set selected book Name
    controller.setSelectedBook(bookName ?? Strings.bibletitle);
    controller.setInitialSelectedBookTypeOptions();

    // //scroll to top
    // controller.readerScrollController.animateTo(
    //   0.0, // Scroll to the top
    //   duration:
    //       const Duration(milliseconds: 500), // Adjust the duration as needed
    //   curve: Curves.easeInOut, // Use a different curve if desired
    // );

    EasyLoading.dismiss();
    controller.selectedRowIndex = -1;
    controller.isLoading = false;

    controller.update();
  }

  setSelectedBook(String selectedBookName) {
    selectedBook = selectedBookName;
    update();
  }

  getFontSize() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? localFontSize =
        await sharedPreferencesStorage.readIntData(Strings.fontSize);
    if (localFontSize != null) {
      fontSize = localFontSize.toDouble();
      update();
    }
  }

  Future<void> loadInitialPage() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Strings.previousPageNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageNo != null) {
        // Check if the widget is still mounted before creating PageController
        if (Get.isRegistered<HomePageController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: pageNo);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(pageNo,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }
      } else {
        if (Get.isRegistered<HomePageController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: 0);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }
      }
    });
  }

  setSelectedBookTypeOptions(String newValue) {
    selectedBookTypeOptions = newValue;
    update();
  }

  setInitialSelectedBookTypeOptions() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Strings.selectedBookKey);
    if (bookName != null) {
      selectedBookTypeOptions = bookName;
    }
    update();
  }

  getPreviousPageNumber() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Strings.previousPageNumber);
    if (pageNo != null) {
      previousOpenedBookPageNumber = pageNo;
    }
    update();
  }

  loadData() async {
    await getterAndSetterController.readData();
    //loadDevotions();
  }

  setTabBarViewInitialIndex(int index) {
    defaultTabBarViewInitialIndex = index;
    update();
  }

  getBooks() async {
    booksList = await DatabaseService().readBookDatabase();
    update();
  }

  getBookName(int bookId) {
    if (books.isNotEmpty) {
      //check if current book is amharic or english
      if (selectedBook.contains("English")) {
        return booksList.where((element) => element.id == bookId).first.title;
      } else {
        return booksList.where((element) => element.id == bookId).first.id;
      }
    }
  }

  getBookTitle(int bookId) {
    if (booksList.isNotEmpty) {
      if (selectedBook.contains("English")) {
        return booksList.where((element) => element.id == bookId).first.title;
      } else {
        return booksList.where((element) => element.id == bookId).first.id;
      }
    }
  }

  setPreviousPageNumber(int pageNumber) async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(
        Strings.previousPageNumber, pageNumber);
  }

  void detachScrollController() {
    readerScrollController = ScrollController();
  }

  setCurrentBookAndChapter(Verses verse) {
    selectedVerse = verse;
    update();
  }

  updateFontSize(double newFontSize) async {
    fontSize = newFontSize;
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(
        Strings.fontSize, fontSize.toInt());
    update();
  }

  navigateToSpecificBookDetailView(int bookId, int chapterId) {
    int indexOfBook = 0;
    for (int i = 0; i < allVerses.length; i++) {
      indexOfBook = allVerses[i].indexWhere(
          (element) => element.book == bookId && element.chapter == chapterId);
      if (indexOfBook != -1) {
        indexOfBook = i;
        break;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (indexOfBook != -1) {
        // Check if the widget is still mounted before creating PageController
        if (Get.isRegistered<HomePageController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: indexOfBook);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(indexOfBook,
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeInOut);
            scaffoldKey.currentState?.closeDrawer();
            scaffoldKey.currentState?.closeEndDrawer();
            readerScrollController.animateTo(
              0.0, // Scroll to the top
              duration: const Duration(
                  milliseconds: 500), // Adjust the duration as needed
              curve: Curves.easeInOut, // Use a different curve if desired
            );
          }
        }
      }
    });
    return indexOfBook;
  }

  getSelectedBookName() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Strings.selectedBookKey);
    if (bookName != null) {
      selectedBook = bookName;
    } else {
      selectedBook = Strings.bibletitle;
    }

    update();
  }

  //!fetching data from api
  // void fetchConfigsData() async {
  //   apiStateHandler.setLoading();
  //   try {
  //     dynamic response =
  //         await httpService.sendHttpRequest(ConfigsHttpAttributes());

  //     // Ensure response.data is a Map<String, dynamic>
  //     if (response.data is Map<String, dynamic>) {
  //       String jsonData = jsonEncode(response.data);

  //       // No need to encode and decode again, just use the data directly
  //       configs = configsFromJson(jsonData);
  //       // Update state with success and response data
  //       apiStateHandler.setSuccess(configs!);
  //       update();
  //     } else {
  //       // Handle the case where response.data is not the expected type
  //       apiStateHandler.setError("Invalid Data");
  //       update();
  //     }
  //   } catch (ex) {
  //     // Update state with error message
  //     String errorMessage = await HandleHttpException().getExceptionString(ex);
  //     apiStateHandler.setError(errorMessage);
  //     update();
  //   }
  // }
}
