import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bible_book_app/app/core/cache/shared_pereferance_storage.dart';
import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/devotion.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/data/models/configs/configs.dart';
import 'package:bible_book_app/app/modules/detail/controllers/configs_http_attribs.dart';
import 'package:bible_book_app/app/modules/detail/helpers/detail_helpers.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailController extends SuperController {
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  List<List<Verses>> allVerses = [];
  AmharicLetter? selectedAmharicLetter;
  FocusNode focusNode = FocusNode();
  String forsearch = '';
  TextEditingController searchController = TextEditingController();
  String selectedBook = "አማርኛ 1954";
  bool isAmharicKeyboardVisible = true;
  String selectedSearchTypeOptions = 'every_word'.tr;
  String selectedSearchPlaceOptions = 'all'.tr;
  String selectedBookTypeOptions = 'አዲሱ መደበኛ ትርጉም';
  List<Verses> searchResultVerses = [];
  List<Book> books = [];
  bool blink = false;
  int? blinkindex;
  int selctedverse = 0;
  List<Book> booksList = [];
  bool hidePageNavigators = false;
  int previousOpenedBookPageNumber = 0;
  int currentPageNumber = 0;
  ScrollController readerScrollController = ScrollController();
  ScrollController drawerScrollController = ScrollController();
  ScrollController drawerChapterScrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageController;
  final GlobalKey pageKey = GlobalKey();
  bool callbackExecuted = false;
  final apiStateHandler = ApiStateHandler<Configs>();
  var httpService = Get.find<HttpService>();
  Configs? configs;
  bool isLoading = false;
  bool isSelectingBook = false;
  double fontSize = SizerUtil.deviceType == DeviceType.mobile ? 12.5 : 8;
  double chapterFontSize = SizerUtil.deviceType == DeviceType.mobile ? 15 : 15;
  List<int> selectedRowIndex = [];
  String drawerQuote = "";
  List<Devotion> devotions = [];
  Verses? selectedVerse;
  int mergeCounter = 0;
  int defaultTabBarViewInitialIndex = 0;
  bool showEnglishKeyboard = false;
  bool showSelectionMenu = false;
  //selection params
  BuildContext? context;
  Verses? verse;
  int index = 0;
  List<Verses> selectedVerses = [];
  bool isKeyboardFormIsPressedFromBasicForm = false;
  int searchFieldCursorIndex = 0;

  List<String> searchPlaceOptions = [
    'ot'.tr,
    'nt'.tr,
    'all'.tr,
  ];

  List<String> searchTypeOptions = [
    'every_word'.tr,
    'exactly'.tr,
  ];

  List<String> bookTypeOptions = [
    'አማርኛ 1954',
    'አዲሱ መደበኛ ትርጉም',
    'English NIV',
    'English KJV'
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
    fetchConfigsData();
    getFontSize();
    getChapterFontSize();
  }

  Future<void> loadDevotions() async {
    devotions = await DatabaseService().readDevotionTable();
    update();
  }

  setTabBarViewInitialIndex(int index) {
    defaultTabBarViewInitialIndex = index;
    update();
  }

  updateforsearch(String newvalue) {
    forsearch = newvalue;
    update();
  }

  updateblink(bool newval) {
    blink = newval;
    update();
  }

  updateblinkindex(int newval) {
    blinkindex = newval;
    update();
  }

  setSelectedVerse(int newVal) {
    selctedverse = newVal;
    update();
  }

  makeSelectedVerseZero() {
    selctedverse = 0;
    update();
  }

  makeblinkindexnull() {
    blinkindex = null;
    update();
  }

  updateshowSelectionMenu(bool newvalue) {
    showSelectionMenu = newvalue;
    update();
  }

  Future<void> loadInitialPage() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Keys.previousPageNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageNo != null) {
        // Check if the widget is still mounted before creating PageController
        if (Get.isRegistered<DetailController>()) {
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
        if (Get.isRegistered<DetailController>()) {
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

  setPreviousPageNumber(int pageNumber) async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(
        Keys.previousPageNumber, pageNumber);
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
    loadDevotions();
  }

  setSelectedAmharicLetter(AmharicLetter selectedAmharicLetterType) {
    selectedAmharicLetter = selectedAmharicLetterType;
    update();
  }

  setSelectedBook(String selectedBookName) {
    selectedBook = selectedBookName;
    update();
  }

  getSelectedBookName() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      selectedBook = bookName;
    } else {
      selectedBook = 'አዲሱ መደበኛ ትርጉም';
    }

    update();
  }

  void onKeyPressed(String keyContent) {
    final currentValue = searchController.text;
    final newValue = currentValue + keyContent;
    searchController.text = newValue;
    update();
  }

  void onBackSpaceKeyPressed() {
    final currentValue = searchController.text;
    List<String> oldValue = currentValue.split('');
    if (oldValue.isNotEmpty) {
      oldValue.removeAt(oldValue.length - 1);
      searchController.text = oldValue.join('');
      update();
    } else {
      searchController.text = '';
      update();
    }
  }

  makeAmharicKeyboardVisible() {
    isAmharicKeyboardVisible = true;
    update();
  }

  makeAmharicKeyboardInVisible() {
    isAmharicKeyboardVisible = false;
    update();
  }

  setSelectedSearchPlaceOptions(String newValue) {
    selectedSearchPlaceOptions = newValue;
    update();
  }

  setSelectedSearchTypeOptions(String newValue) {
    selectedSearchTypeOptions = newValue;
    update();
  }

  setSelectedBookTypeOptions(String newValue) {
    selectedBookTypeOptions = newValue;
    update();
  }

  Future<List<Verses>> search({
    required String BibleType,
    required String searchType,
    required String searchPlace,
    required String query,
  }) async {
    isLoading = true;
    update();
    List<Verses> emptyVerses = [];
    if (searchType == 'every_word'.tr) {
      if (searchPlace == 'ot'.tr) {
        isLoading = false;
        update();
        return await handleSearch("OT", query, 'contains', BibleType);
      } else if (searchPlace == 'nt'.tr) {
        isLoading = false;
        update();
        return await handleSearch("NT", query, 'contains', BibleType);
      } else if (searchPlace == 'all'.tr) {
        isLoading = false;
        update();
        return await handleSearch("", query, 'contains', BibleType);
      } else {
        isLoading = false;
        update();
        return emptyVerses;
      }
    } else if (searchType == 'exactly'.tr) {
      if (searchPlace == 'ot'.tr) {
        isLoading = false;
        update();
        return await handleSearch("OT", query, 'exact', BibleType);
      } else if (searchPlace == 'nt'.tr) {
        isLoading = false;
        update();
        return await handleSearch("NT", query, 'exact', BibleType);
      } else if (searchPlace == 'all'.tr) {
        isLoading = false;
        update();
        return await handleSearch("", query, 'exact', BibleType);
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

  changeBibleFromSearch(String bibleType) async {
    String saveName = "";
    if (bibleType == 'AMHKJV') {
      saveName = "አማርኛ 1954";
    } else if (bibleType == 'AMHNIV') {
      saveName = "አዲሱ መደበኛ ትርጉም";
    } else if (bibleType == 'ENGNIV') {
      saveName = "English NIV";
    } else if (bibleType == 'ENGKJV') {
      saveName = "English KJV";
    }
    //changing book type
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    getterAndSetterController.versesAMH =
        await DatabaseService().changeBibleType(bibleType);
    getterAndSetterController.update();
    allVerses.assignAll(getterAndSetterController.groupedBookList());
    //saving selected book to local storage
    sharedPreferencesStorage.saveStringData(Keys.selectedBookKey, saveName);
    //set selected book Name
    setSelectedBook(saveName);
    update();
  }

  Future<List<Verses>> handleSearch(
    String testament,
    String query,
    String searchOption,
    String BibleType,
  ) async {
    if (BibleType == 'አማርኛ 1954') {
      BibleType = "AMHKJV";
    } else if (BibleType == 'አዲሱ መደበኛ ትርጉም') {
      BibleType = "AMHNIV";
    } else if (BibleType == 'English NIV') {
      BibleType = "ENGNIV";
    } else if (BibleType == 'English KJV') {
      BibleType = "ENGKJV";
    }
    List<Verses> verses = await DatabaseService().changeBibleType(BibleType);
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
        await changeBibleFromSearch(BibleType);
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
        await changeBibleFromSearch(BibleType);
      }
      return searchResults;
    } else {
      List<Verses> emptyVerses = [];
      return emptyVerses;
    }
  }

  getBookName(int bookId) {
    if (books.isNotEmpty) {
      //check if current book is amharic or english
      if (selectedBookTypeOptions.contains("አ")) {
        // books = await DatabaseService().readBookDatabase();
        return books.where((element) => element.id == bookId).first.titleGeez;
      } else {
        return books.where((element) => element.id == bookId).first.title;
      }
    }
  }

  clearSearchBar() {
    searchController.clear();
    searchResultVerses.clear();
    selectedAmharicLetter = null;
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
        return booksList
            .where((element) => element.id == bookId)
            .first
            .titleGeez;
      }
    }
  }

  getAMHBookinfo(String bookchaptertitle) {
    if (booksList.isNotEmpty) {
      return booksList
          .where((element) => element.title == bookchaptertitle)
          .first
          .titleGeez;
    }
  }

  getENGBookinfofromAMH(String bookchaptertitle) {
    if (booksList.isNotEmpty) {
      return booksList
          .where((element) => element.titleGeez == bookchaptertitle)
          .first
          .title;
    }
  }

  getENGBookinfo(String bookchaptertitle) {
    if (booksList.isNotEmpty) {
      return booksList
          .where((element) => element.title == bookchaptertitle)
          .first
          .title;
    }
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
        if (Get.isRegistered<DetailController>()) {
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
            // readerScrollController.animateTo(
            //   0.0, // Scroll to the top
            //   duration: const Duration(
            //       milliseconds: 500), // Adjust the duration as needed
            //   curve: Curves.easeInOut, // Use a different curve if desired
            // );
          }
        }
      }
    });
    return indexOfBook;
  }

  void detachScrollController() {
    readerScrollController = ScrollController();
  }

  //fetching data from api
  void fetchConfigsData() async {
    apiStateHandler.setLoading();
    try {
      dynamic response =
          await httpService.sendHttpRequest(ConfigsHttpAttributes());

      // Ensure response.data is a Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        String jsonData = jsonEncode(response.data);

        // No need to encode and decode again, just use the data directly
        configs = configsFromJson(jsonData);
        // Update state with success and response data
        apiStateHandler.setSuccess(configs!);
        update();
      } else {
        // Handle the case where response.data is not the expected type
        apiStateHandler.setError("Invalid Data");
        update();
      }
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      apiStateHandler.setError(errorMessage);
      update();
    }
  }

  void openWebBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  saveLocale(String locale) async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveStringData(Keys.selectedLocale, locale);
  }

  updateFontSize(double newFontSize) async {
    fontSize = newFontSize;
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(Keys.fontSize, fontSize.toInt());
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

  updateChapterFontSize(double newFontSize) async {
    fontSize = newFontSize;
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(
        Keys.chapterFontSize, fontSize.toInt());
    update();
  }

  getChapterFontSize() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? localFontSize =
        await sharedPreferencesStorage.readIntData(Keys.chapterFontSize);
    if (localFontSize != null) {
      fontSize = localFontSize.toDouble();
      update();
    }
  }

  String generateRandomQuote(String locale) {
    Random random = Random();
    int devotionIndex = random.nextInt(devotions.length);
    Devotion devotion = devotions[devotionIndex];
    String randomQuote = "${devotion.verse}\n${devotion.verseLocation}";
    return randomQuote;
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String androidAppLink =
        'Check out this app: https://play.google.com/store/apps/details?id=com.kidssoftwares.learnenglish';
    const String iosAppLink =
        'Check out this app: https://apps.apple.com/us/app/amharic-english-dictionary/id1071075334';

    Platform.isAndroid
        ? await Share.share('Share App', subject: androidAppLink)
        : await Share.share('Share App', subject: iosAppLink);
  }

  Future<void> rateApp() async {
    if (Platform.isAndroid) {
      StoreRedirect.redirect(androidAppId: "com.kidssoftwares.learnenglish");
    } else {
      DetailHelpers().launchWebUrl(
          "https://apps.apple.com/app/id1071075334?action=write-review");
    }
  }

  setCurrentBookAndChapter(Verses verse) {
    selectedVerse = verse;
    update();
  }

  openEnglishKeyboard() {
    showEnglishKeyboard = true;
    SystemChannels.textInput.invokeMethod("TextInput.show");
    update();
  }

  toggleSelectedRowIndex(int index, Verses verse) {
    bool exists =
        selectedVerses.any((element) => element.verseText == verse.verseText);
    if (exists) {
      selectedRowIndex.remove(index);
      selectedVerses.remove(verse);
    } else {
      selectedRowIndex.add(index);
      selectedVerses.add(verse);
    }
  }

  removeSelectedRowIndex(int index) {
    bool exists = selectedRowIndex.any((element) => element == index);
    if (exists) {
      selectedRowIndex.remove(index);
      selectedVerses.remove(verse);
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    if (Platform.isIOS) {
      fetchConfigsData();
      update();
    }
  }
}
