import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/utils/keys.dart';

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
  String selectedBookTypeOptions = Keys.bibletitle;

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

  Future<void> loadInitialData() async {
    final HomePageController controller = Get.find<HomePageController>();
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);

    await EasyLoading.show(status: '...');

    controller.isLoading = true;
    controller.update();
    // SharedPreferencesStorage sharedPreferencesStorage =
    //     SharedPreferencesStorage();
    getterAndSetterController.versesAMH =
        await DatabaseService().changeBibleType(bookName ?? Keys.bibletitle);
    getterAndSetterController.update();
    controller.allVerses.assignAll(getterAndSetterController.groupedBookList());

    //saving selected book to local storage
    sharedPreferencesStorage.saveStringData(
        Keys.selectedBookKey, bookName ?? Keys.bibletitle);
    //set selected book Name
    controller.setSelectedBook(bookName ?? Keys.bibletitle);
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
        await sharedPreferencesStorage.readIntData(Keys.fontSize);
    if (localFontSize != null) {
      fontSize = localFontSize.toDouble();
      update();
    }
  }

  Future<void> loadInitialPage() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Keys.previousPageNumber);
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
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      selectedBookTypeOptions = bookName;
    }
    update();
  }

  getPreviousPageNumber() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Keys.previousPageNumber);
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
        Keys.previousPageNumber, pageNumber);
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
    await sharedPreferencesStorage.saveIntData(Keys.fontSize, fontSize.toInt());
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
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      selectedBook = bookName;
    } else {
      selectedBook = Keys.bibletitle;
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
