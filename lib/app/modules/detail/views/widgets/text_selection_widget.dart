import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/highlight_color.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:bible_book_app/app/utils/helpers/get_and_set_highlight_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../home/controllers/home_controller.dart';
import '../../../settings/views/settings_view.dart';

Widget textSelectionOptions(BuildContext context, List<Verses> selectedVerses,
    Verses? verse, int index) {
  final DetailController detailController = Get.find<DetailController>();
  final ThemeController themeData = Get.find<ThemeController>();
  return GetBuilder<DetailController>(
    init: DetailController(),
    initState: (_) {},
    builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizerUtil.deviceType != DeviceType.mobile
                ? MediaQuery.of(context).size.width / 7
                : 0),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: themeData.themeData.value!.backgroundColor,
              border: const Border(top: BorderSide(color: Colors.grey))),
          padding: const EdgeInsets.only(bottom: 5, top: 15, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (verse?.highlight != 0) {
                            for (int i = 0;
                                i < detailController.selectedVerses.length;
                                i++) {
                              await DatabaseService().updateHighlight(
                                  selectedVerses[i].book!,
                                  selectedVerses[i].chapter!,
                                  selectedVerses[i].verseNumber,
                                  0,
                                  detailController.selectedBook);
                              selectedVerses[i].highlight = 0;
                            }
                            detailController.selectedRowIndex = [];
                            detailController.selectedVerses = [];
                            detailController.showSelectionMenu = false;
                            detailController.update();
                          } else {
                            detailController.selectedRowIndex = [];
                            detailController.selectedVerses = [];
                            detailController.showSelectionMenu = false;
                            detailController.update();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 201, 200, 200),
                              radius: 20,
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          onTap: () async {
                            int color = setHighlightColor(
                                HighlightColors.highlightGreen);
                            for (int i = 0;
                                i < detailController.selectedVerses.length;
                                i++) {
                              await DatabaseService().updateHighlight(
                                  selectedVerses[i].book!,
                                  selectedVerses[i].chapter!,
                                  selectedVerses[i].verseNumber,
                                  color,
                                  detailController.selectedBook);
                              selectedVerses[i].highlight = color;
                            }
                            detailController.selectedRowIndex = [];
                            detailController.selectedVerses = [];
                            detailController.showSelectionMenu = false;
                            detailController.update();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    Colors.grey, // Set the color of the border
                                width: 1.0, // Set the width of the border
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: HighlightColors.highlightGreen,
                              radius: 20,
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightYellow);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightYellow,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightOrange);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightOrange,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightRed);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightRed,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightBlue);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightBlue,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightPink);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightPink,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightDarkGreen);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightDarkGreen,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightDarkYellow);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor:
                                HighlightColors.highlightDarkYellow,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightDarkTeal);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightDarkTeal,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightBrown);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightBrown,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightLightRed);
                          for (int i = 0;
                              i < detailController.selectedVerses.length;
                              i++) {
                            await DatabaseService().updateHighlight(
                                selectedVerses[i].book!,
                                selectedVerses[i].chapter!,
                                selectedVerses[i].verseNumber,
                                color,
                                detailController.selectedBook);
                            selectedVerses[i].highlight = color;
                          }
                          detailController.selectedRowIndex = [];
                          detailController.selectedVerses = [];
                          detailController.showSelectionMenu = false;
                          detailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // Set the color of the border
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: HighlightColors.highlightLightRed,
                            radius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 1),
                  child: Divider(
                    color: themeData.themeData.value!.grayTextColor
                        .withOpacity(0.5),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      //!Share
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                String textToCopy = "";
                                for (int i = 0;
                                    i < detailController.selectedVerses.length;
                                    i++) {
                                  String tempTextToCopy = "";

                                  if (detailController.selectedBook
                                      .contains("English")) {
                                    tempTextToCopy =
                                        "\"${selectedVerses[i].verseText!}\" — ${detailController.getBookTitle(selectedVerses[i].book!)} ${selectedVerses[i].chapter}:${selectedVerses[i].verseNumber}";
                                  } else {
                                    tempTextToCopy =
                                        "\"${selectedVerses[i].verseText!}\" — ${detailController.getBookTitle(selectedVerses[i].book!)} ${selectedVerses[i].chapter}፥${selectedVerses[i].verseNumber}";
                                  }
                                  textToCopy =
                                      textToCopy + "\n ${tempTextToCopy}";
                                }
                                await share(textToCopy, "Share", context);
                              },
                              icon: Icon(
                                Icons.share,
                                color: themeData.themeData.value!.verseColor,
                              )),
                          Text(
                            'share'.tr,
                            style: TextStyle(
                                color: themeData.themeData.value!.verseColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //!Copy
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                String textToCopy = "";
                                for (int i = 0;
                                    i < detailController.selectedVerses.length;
                                    i++) {
                                  String tempTextToCopy = "";
                                  if (detailController.selectedBook
                                      .contains("English")) {
                                    tempTextToCopy =
                                        "\"${selectedVerses[i].verseText!}\" — ${detailController.getBookTitle(selectedVerses[i].book!)} ${selectedVerses[i].chapter}:${selectedVerses[i].verseNumber}";
                                  } else {
                                    tempTextToCopy =
                                        "\"${selectedVerses[i].verseText!}\" — ${detailController.getBookTitle(selectedVerses[i].book!)} ${selectedVerses[i].chapter}፥${selectedVerses[i].verseNumber}";
                                  }
                                  textToCopy =
                                      textToCopy + "\n ${tempTextToCopy}";
                                }

                                copyToClipboard(textToCopy);
                              },
                              icon: Icon(
                                Icons.copy,
                                color: themeData.themeData.value!.verseColor,
                              )),
                          Text(
                            'copy'.tr,
                            style: TextStyle(
                                color: themeData.themeData.value!.verseColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      //!Compare
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                // BuildContext context,
                                // String selectedbookname,
                                // String selectedbooktitle,
                                // String verse
                                if (selectedVerses.isNotEmpty) {
                                  compare(
                                      context,
                                      '${detailController.getBookTitle(selectedVerses[0].book!)}',
                                      '${selectedVerses[0].chapter}',
                                      '${selectedVerses[0].verseNumber}',
                                      selectedVerses[0].verseText!,
                                      selectedVerses[0].book!);
                                } else {
                                  detailController
                                      .updateshowSelectionMenu(false);
                                }
                              },
                              icon: Icon(
                                Icons.compare_outlined,
                                color: themeData.themeData.value!.verseColor,
                              )),
                          Text(
                            'compare'.tr,
                            style: TextStyle(
                                color: themeData.themeData.value!.verseColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      //!fontSize
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                showFontSizeBottomSheet(context);
                              },
                              icon: Icon(
                                Icons.format_size_outlined,
                                color: themeData.themeData.value!.verseColor,
                              )),
                          Text(
                            'font_size'.tr,
                            style: TextStyle(
                                color: themeData.themeData.value!.verseColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      //!Rate
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                detailController.rateApp();
                              },
                              icon: Icon(
                                Icons.star,
                                color: themeData.themeData.value!.verseColor,
                              )),
                          Text(
                            'rate'.tr,
                            style: TextStyle(
                                color: themeData.themeData.value!.verseColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void copyToClipboard(String text) {
  final DetailController detailController = Get.find<DetailController>();
  final themeData = Get.find<ThemeController>().themeData.value;
  Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
      msg: "Copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: themeData?.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
  detailController.selectedRowIndex = [];
  detailController.selectedVerses = [];
  detailController.showSelectionMenu = false;
  detailController.update();
}

Future<void> share(String text, String subject, BuildContext context) async {
  final DetailController detailController = Get.find<DetailController>();
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
    text,
    subject: subject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
  detailController.selectedRowIndex = [];
  detailController.selectedVerses = [];
  detailController.showSelectionMenu = false;
  detailController.update();
}

Future<void> compare(
  BuildContext context,
  String chapterName,
  String chapterNumber,
  String versrNumber,
  String verse,
  int book,
) async {
  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CompareDialog(
        verse: verse,
        chapterName: chapterName,
        chapterNumber: chapterNumber,
        versrNumber: versrNumber,
        book: book,
      );
    },
  );
}

class CompareDialog extends StatefulWidget {
  final String chapterName;
  final String chapterNumber;
  final String versrNumber;
  final String verse;
  final int book;
  const CompareDialog({
    Key? key,
    required this.chapterName,
    required this.chapterNumber,
    required this.versrNumber,
    required this.verse,
    required this.book,
  }) : super(key: key);

  @override
  State<CompareDialog> createState() => _CompareDialogState();
}

class _CompareDialogState extends State<CompareDialog> {
  final DetailController detailController = Get.find<DetailController>();
  final ThemeController themeData = Get.find<ThemeController>();
  final HomeController homeController = Get.find<HomeController>();

  String eNGKJVverseText = '';
  String eNGNIVverseText = '';
  String aMHNIVverseText = '';
  String aMHKJVverseText = '';

  @override
  void initState() {
    super.initState();
    initclass();
  }

  Future<void> initclass() async {
    await EasyLoading.show(status: 'Please Wait...');
    eNGKJVverseText = await DatabaseService().readVersesfromDB(
        'ENGKJV',
        int.tryParse(widget.chapterNumber)!,
        int.tryParse(widget.versrNumber)!,
        widget.book);
    eNGNIVverseText = await DatabaseService().readVersesfromDB(
        'ENGNIV',
        int.tryParse(widget.chapterNumber)!,
        int.tryParse(widget.versrNumber)!,
        widget.book);
    aMHNIVverseText = await DatabaseService().readVersesfromDB(
        'AMHNIV',
        int.tryParse(widget.chapterNumber)!,
        int.tryParse(widget.versrNumber)!,
        widget.book);
    aMHKJVverseText = await DatabaseService().readVersesfromDB(
        'AMHKJV',
        int.tryParse(widget.chapterNumber)!,
        int.tryParse(widget.versrNumber)!,
        widget.book);
    setState(() {});
    if (eNGKJVverseText != '' &&
        eNGNIVverseText != '' &&
        aMHNIVverseText != '' &&
        aMHKJVverseText != '') {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    String sepa = ':';
    detailController.selectedBook.contains("አዲሱ")
        ? sepa = '፤'
        : detailController.selectedBook.contains("1954")
            ? sepa = ' '
            : sepa = ' ';

    return AlertDialog(
      backgroundColor: themeData.themeData.value!.backgroundColor,
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'compare'.tr,
        style: TextStyle(
            color: themeData.themeData.value!.verseColor, fontSize: 15.sp),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${detailController.selectedBook} - ${widget.chapterName} ${widget.chapterNumber}:${widget.versrNumber}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.versrNumber}$sepa ',
                      style: TextStyle(
                        fontSize: detailController.fontSize.sp,
                        color: themeData.themeData.value!.numbersColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.verse,
                      style: TextStyle(
                        fontSize: detailController.fontSize.sp,
                        color: themeData.themeData.value!.verseColor,
                        fontFamily: "Abyssinica",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // አዲሱ መደበኛ ትርጉም
            if (detailController.selectedBook != 'አዲሱ መደበኛ ትርጉም')
              buildVerseContainer(
                  'አዲሱ መደበኛ ትርጉም',
                  aMHNIVverseText,
                  '፤ ',
                  detailController.selectedBook.contains('Eng')
                      ? detailController.getAMHBookinfo(widget.chapterName)
                      : widget.chapterName),
            // አማርኛ 1954
            if (detailController.selectedBook != 'አማርኛ 1954')
              buildVerseContainer(
                  'አማርኛ 1954',
                  aMHKJVverseText,
                  '',
                  detailController.selectedBook.contains('Eng')
                      ? detailController.getAMHBookinfo(widget.chapterName)
                      : widget.chapterName),
            // English KJV
            if (detailController.selectedBook != 'English KJV')
              buildVerseContainer(
                  'English KJV',
                  eNGKJVverseText,
                  ': ',
                  detailController.selectedBook.contains('Eng')
                      ? widget.chapterName
                      : detailController
                          .getENGBookinfofromAMH(widget.chapterName)),
            // English NIV
            if (detailController.selectedBook != 'English NIV')
              buildVerseContainer(
                  'English NIV',
                  eNGNIVverseText,
                  ': ',
                  detailController.selectedBook.contains('Eng')
                      ? widget.chapterName
                      : detailController
                          .getENGBookinfofromAMH(widget.chapterName)),

            const SizedBox(height: 8.0),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            detailController.updateshowSelectionMenu(false);
            Navigator.of(context).pop();
          },
          child: Text(
            'close'.tr,
            style: TextStyle(color: themeData.themeData.value!.verseColor),
          ),
        ),
      ],
    );
  }

  Widget buildVerseContainer(
      String title, String verseText, String separ, String chapName) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$title - $chapName ${widget.chapterNumber}:${widget.versrNumber}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.versrNumber}$separ',
                  style: TextStyle(
                    fontSize: detailController.fontSize.sp,
                    color: themeData.themeData.value!.numbersColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: verseText,
                  style: TextStyle(
                    fontSize: detailController.fontSize.sp,
                    color: themeData.themeData.value!.verseColor,
                    fontFamily: "Abyssinica",
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
