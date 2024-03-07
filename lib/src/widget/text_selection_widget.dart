import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:holy_bible_app/src/utils/appcolor.dart';
import 'package:share_plus/share_plus.dart';

import '../model/bible/verses.dart';
import '../services/database_service.dart';
import '../utils/get_and_set_highlight_color.dart';
import 'highlight_color.dart';

void textSelectionOptions(BuildContext context, int book, int chapter,
    int verseNumber, String tableName, Verses? verse) {
  final HomePageController homepageController = Get.find<HomePageController>();
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2))),
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<HomePageController>(
        init: HomePageController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            padding:
                const EdgeInsets.only(bottom: 5, top: 15, left: 5, right: 5),
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
                            await DatabaseService().updateHighlight(
                                book, chapter, verseNumber, 0, tableName);
                            homepageController.selectedRowIndex = -1;
                            verse?.highlight = 0;
                            homepageController.update();
                          } else {
                            homepageController.selectedRowIndex = -1;
                            homepageController.update();
                            Get.back();
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
                            await DatabaseService().updateHighlight(
                                book, chapter, verseNumber, color, tableName);
                            homepageController.selectedRowIndex = -1;
                            verse?.highlight = color;
                            homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                          await DatabaseService().updateHighlight(
                              book, chapter, verseNumber, color, tableName);
                          homepageController.selectedRowIndex = -1;
                          verse?.highlight = color;
                          homepageController.update();
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
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 1),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              String textToCopy = "";
                              if (tableName.contains("English")) {
                                textToCopy =
                                    "\"${verse!.verseText!}\" — ${homepageController.getBookTitle(verse.book!)} ${verse.chapter}:${verse.verseNumber}";
                              } else {
                                textToCopy =
                                    "\"${verse!.verseText!}\" — ${homepageController.getBookTitle(verse.book!)} ${verse.chapter}፥${verse.verseNumber}";
                              }
                              await share(textToCopy, "Share", context);
                            },
                            icon: const Icon(Icons.share)),
                        const Text("Share")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              String textToCopy = "";
                              if (tableName.contains("English")) {
                                textToCopy =
                                    "\"${verse!.verseText!}\" — ${homepageController.getBookTitle(verse.book!)} ${verse.chapter}:${verse.verseNumber}";
                              } else {
                                textToCopy =
                                    "\"${verse!.verseText!}\" — ${homepageController.getBookTitle(verse.book!)} ${verse.chapter}፥${verse.verseNumber}";
                              }

                              copyToClipboard(textToCopy);
                            },
                            icon: const Icon(Icons.copy)),
                        const Text("Copy")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      );
    },
  ).whenComplete(() {
    homepageController.selectedRowIndex = -1;
    homepageController.update();
  });
}

void copyToClipboard(String text) {
  final HomePageController homepageController = Get.find<HomePageController>();
  Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
      msg: "Copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
  homepageController.selectedRowIndex = -1;
  homepageController.update();
  Get.back();
}

Future<void> share(String text, String subject, BuildContext context) async {
  final HomePageController homepageController = Get.find<HomePageController>();
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
    text,
    subject: subject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
  homepageController.selectedRowIndex = -1;
  homepageController.update();
  Get.back();
}
