import 'package:spanish_bible/app/core/shared_controllers/database_service.dart';
import 'package:spanish_bible/app/core/shared_controllers/theme_controller.dart';
import 'package:spanish_bible/app/data/models/bible/versesAMH.dart';
import 'package:spanish_bible/app/modules/detail/controllers/detail_controller.dart';
import 'package:spanish_bible/app/modules/detail/views/amharic_keyboard.dart';
import 'package:spanish_bible/app/modules/detail/views/widgets/highlight_color.dart';
import 'package:spanish_bible/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:spanish_bible/app/utils/helpers/get_and_set_highlight_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/keys/keys.dart';
import '../../../../utils/shared_widgets/custom_easy_loading.dart';
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
        color: themeData.themeData.value!.backgroundColor,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizerUtil.deviceType != DeviceType.mobile ? 0 : 0),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: themeData.themeData.value!.backgroundColor,
                border: const Border(top: BorderSide(color: Colors.grey))),
            padding:
                const EdgeInsets.only(bottom: 5, top: 15, left: 5, right: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                color:
                                    Colors.grey, // Set the color of the border
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
                                  color: Colors
                                      .grey, // Set the color of the border
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
                                color:
                                    Colors.grey, // Set the color of the border
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
                                color:
                                    Colors.grey, // Set the color of the border
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
                                color:
                                    Colors.grey, // Set the color of the border
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
                            int color = setHighlightColor(
                                HighlightColors.highlightBlue);
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
                            int color = setHighlightColor(
                                HighlightColors.highlightPink);
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
                                color:
                                    Colors.grey, // Set the color of the border
                                width: 1.0, // Set the width of the border
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor:
                                  HighlightColors.highlightDarkGreen,
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
                                color:
                                    Colors.grey, // Set the color of the border
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
                                color:
                                    Colors.grey, // Set the color of the border
                                width: 1.0, // Set the width of the border
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor:
                                  HighlightColors.highlightDarkTeal,
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
                                HighlightColors.highlightBrown);
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
                                color:
                                    Colors.grey, // Set the color of the border
                                width: 1.0, // Set the width of the border
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor:
                                  HighlightColors.highlightLightRed,
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
                        top: 5, left: 0, right: 0, bottom: 1),
                    child: Divider(
                      color: themeData.themeData.value!.grayTextColor
                          .withOpacity(0.5),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      i <
                                          detailController
                                              .selectedVerses.length;
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
                                  await share(
                                      textToCopy.trimLeft(), "Share", context);
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
                                      i <
                                          detailController
                                              .selectedVerses.length;
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
                                    selectedVerses.sort((a, b) =>
                                        a.verseNumber.compareTo(b.verseNumber));

                                    compare(context, selectedVerses
                                        // '${detailController.getBookTitle(selectedVerses[0].book!)}',
                                        // '${selectedVerses[0].chapter}',
                                        // '${selectedVerses[0].verseNumber}',
                                        // selectedVerses[0].verseText!,
                                        // selectedVerses[0].book!

                                        );
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

Future<void> compare(BuildContext context, List<Verses> selectedVerse
    // String chapterName,
    // String chapterNumber,
    // String versrNumber,
    // String verse,
    // int book,
    ) async {
  //! '${detailController.getBookTitle(selectedVerses[0].book!)}',
  //! '${selectedVerses[0].chapter}',
  //! '${selectedVerses[0].verseNumber}',
  //! selectedVerses[0].verseText!,
  //! selectedVerses[0].book!

  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CompareDialog(selectedVerses: selectedVerse
          // verse: verse,
          // chapterName: chapterName,
          // chapterNumber: chapterNumber,
          // versrNumber: versrNumber,
          // book: book,
          );
    },
  );
}

class CompareDialog extends StatefulWidget {
  final List<Verses> selectedVerses;
  // final String chapterName;
  // final String chapterNumber;
  // final String versrNumber;
  // final String verse;
  // final int book;
  const CompareDialog({
    Key? key,
    required this.selectedVerses,
    // required this.chapterName,
    // required this.chapterNumber,
    // required this.versrNumber,
    // required this.verse,
    // required this.book,
  }) : super(key: key);

  @override
  State<CompareDialog> createState() => _CompareDialogState();
}

class _CompareDialogState extends State<CompareDialog> {
  final DetailController detailController = Get.find<DetailController>();
  final ThemeController themeData = Get.find<ThemeController>();
  final HomeController homeController = Get.find<HomeController>();

  List<String> eNGKJVverseText = [];
  List<String> eNGNIVverseText = [];
  List<String> aMHNIVverseText = [];
  List<String> spnKJVverseText = [];

  @override
  void initState() {
    super.initState();
    // initclass();
  }

  //! '${detailController.getBookTitle(selectedVerses[0].book!)}',
  //! '${selectedVerses[0].chapter}',
  //! '${selectedVerses[0].verseNumber}',
  //! selectedVerses[0].verseText!,
  //! selectedVerses[0].book!

  Future<void> initclass() async {
    CustomEasyLoading.getInstance().showLoading();

    for (var verse in widget.selectedVerses) {
      eNGKJVverseText.add(await DatabaseService().readVersesfromDB(
          'ENGKJV', verse.chapter!, verse.verseNumber!, verse.book!));
      eNGNIVverseText.add(await DatabaseService().readVersesfromDB(
          'ENGNIV', verse.chapter!, verse.verseNumber!, verse.book!));
      aMHNIVverseText.add(await DatabaseService().readVersesfromDB(
          Keys.secondbible, verse.chapter!, verse.verseNumber!, verse.book!));
      spnKJVverseText.add(await DatabaseService().readVersesfromDB(
          Keys.defaultbible, verse.chapter!, verse.verseNumber!, verse.book!));
    }

    CustomEasyLoading.getInstance().dismissLoading();
  }

//   Future<void> initclass() async {
//   for (var verse in widget.selectedVerses) {
//     eNGKJVverseText.add(await DatabaseService().readVersesfromDB(
//         'ENGKJV', verse.chapter!, verse.verseNumber!, verse.book!));
//     eNGNIVverseText.add(await DatabaseService().readVersesfromDB(
//         'ENGNIV', verse.chapter!, verse.verseNumber!, verse.book!));
//     aMHNIVverseText.add(await DatabaseService().readVersesfromDB(
//         'AMHNIV', verse.chapter!, verse.verseNumber!, verse.book!));
//     aMHKJVverseText.add(await DatabaseService().readVersesfromDB(
//         'AMHKJV', verse.chapter!, verse.verseNumber!, verse.book!));
//   }
// }

  @override
  Widget build(BuildContext context) {
    String sepa = ':';
    String chapterNAME =
        detailController.getBookTitle(detailController.selectedVerses[0].book!);
    detailController.selectedBook.contains("አዲሱ")
        ? sepa = '፤'
        : detailController.selectedBook.contains("1954")
            ? sepa = ' '
            : sepa = ' ';

    return FutureBuilder<void>(
        future: initclass(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Build your UI here using the verse texts
            return AlertDialog(
              backgroundColor: themeData.themeData.value!.backgroundColor,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'compare'.tr,
                style: TextStyle(
                    color: themeData.themeData.value!.verseColor,
                    fontSize: 15.sp),
              ),
              content: SizedBox(
                height: 70.h,
                width: 80.w,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var lVerse = widget.selectedVerses[index];
                      String valch = lVerse.chapter!.toString();
                      return Column(
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
                              '${detailController.selectedBook} - ${detailController.getBookTitle(lVerse.book!)} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.selectedVerses.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var lVerse = widget.selectedVerses[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${lVerse.verseNumber!}$sepa ',
                                          style: TextStyle(
                                            fontSize:
                                                detailController.fontSize.sp,
                                            color: themeData
                                                .themeData.value!.numbersColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${lVerse.verseText!}",
                                          style: TextStyle(
                                            fontSize:
                                                detailController.fontSize.sp,
                                            color: themeData
                                                .themeData.value!.verseColor,
                                            fontFamily: "Abyssinica",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          // if (detailController.selectedBook != 'አዲሱ መደበኛ ትርጉም')
                          //   Column(children: [
                          //     Container(
                          //       width: double.infinity,
                          //       color: Colors.grey,
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         'አዲሱ መደበኛ ትርጉም - ${detailController.selectedBook.contains('Eng') ? detailController.getAMHBookinfo(chapterNAME) : chapterNAME} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                          //         style: const TextStyle(color: Colors.white),
                          //       ),
                          //     ),
                          //     const SizedBox(height: 8.0),
                          //     ListView.builder(
                          //         shrinkWrap: true,
                          //         itemCount: widget.selectedVerses.length,
                          //         physics: const NeverScrollableScrollPhysics(),
                          //         itemBuilder: (context, index) {
                          //           var lVerse = widget.selectedVerses[index];
                          //           return Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 5.0),
                          //             child: RichText(
                          //               text: TextSpan(
                          //                 children: [
                          //                   TextSpan(
                          //                     text: '${lVerse.verseNumber!}፤ ',
                          //                     style: TextStyle(
                          //                       fontSize: detailController
                          //                           .fontSize.sp,
                          //                       color: themeData.themeData
                          //                           .value!.numbersColor,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                   ),
                          //                   TextSpan(
                          //                     text:
                          //                         ' ${aMHNIVverseText[index]}',
                          //                     style: TextStyle(
                          //                       fontSize: detailController
                          //                           .fontSize.sp,
                          //                       color: themeData.themeData
                          //                           .value!.verseColor,
                          //                       fontFamily: "Abyssinica",
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         }),
                          //   ]),
                          if (detailController.selectedBook !=
                              Keys.defaultbibleName)
                            Column(children: [
                              Container(
                                width: double.infinity,
                                color: Colors.grey,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${Keys.defaultbibleName} - ${detailController.selectedBook.contains('Eng') ? detailController.getAMHBookinfo(chapterNAME) : chapterNAME} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.selectedVerses.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var lVerse = widget.selectedVerses[index];
                                    String verset = spnKJVverseText[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${lVerse.verseNumber!} ',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.numbersColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: verset,
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.verseColor,
                                                fontFamily: "Abyssinica",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ]),

                          if (detailController.selectedBook !=
                              Keys.secondbibleName)
                            Column(children: [
                              Container(
                                width: double.infinity,
                                color: Colors.grey,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${Keys.secondbibleName} - ${detailController.selectedBook.contains('Eng') ? detailController.getAMHBookinfo(chapterNAME) : chapterNAME} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.selectedVerses.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var lVerse = widget.selectedVerses[index];
                                    String verset = aMHNIVverseText[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${lVerse.verseNumber!} ',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.numbersColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: verset,
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.verseColor,
                                                fontFamily: "Abyssinica",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ]),

                          if (detailController.selectedBook != 'English KJV')
                            Column(children: [
                              Container(
                                width: double.infinity,
                                color: Colors.grey,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'English KJV - ${detailController.selectedBook.contains('Eng') ? chapterNAME : detailController.getENGBookinfofromAMH(chapterNAME)} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.selectedVerses.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var lVerse = widget.selectedVerses[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${lVerse.verseNumber!}:',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.numbersColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${eNGKJVverseText[index]}',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.verseColor,
                                                fontFamily: "Abyssinica",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ]),

                          if (detailController.selectedBook != 'English NIV')
                            Column(children: [
                              Container(
                                width: double.infinity,
                                color: Colors.grey,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'English NIV - ${detailController.selectedBook.contains('Eng') ? chapterNAME : detailController.getENGBookinfofromAMH(chapterNAME)} ${lVerse.chapter!}:${lVerse.verseNumber!}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.selectedVerses.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var lVerse = widget.selectedVerses[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${lVerse.verseNumber!}:',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.numbersColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${eNGNIVverseText[index]}',
                                              style: TextStyle(
                                                fontSize: detailController
                                                    .fontSize.sp,
                                                color: themeData.themeData
                                                    .value!.verseColor,
                                                fontFamily: "Abyssinica",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ]),

                          // // አዲሱ መደበኛ ትርጉም
                          // if (detailController.selectedBook != 'አዲሱ መደበኛ ትርጉም')
                          //   buildVerseContainer('አዲሱ መደበኛ ትርጉም', '፤ ', lVerse),
                          // // አማርኛ 1954
                          // if (detailController.selectedBook != 'አማርኛ 1954')
                          //   buildVerseContainer(
                          //       'አማርኛ 1954',
                          //       '',
                          //       // detailController.selectedBook.contains('Eng')
                          //       //     ? detailController.getAMHBookinfo(
                          //       //         detailController.getBookTitle(lVerse.book!))
                          //       //     : detailController.getBookTitle(lVerse.book!),
                          //       lVerse),
                          // // English KJV
                          // if (detailController.selectedBook != 'English KJV')
                          //   buildVerseContainer('English KJV', ': ', lVerse),
                          // // English NIV
                          // if (detailController.selectedBook != 'English NIV')
                          //   buildVerseContainer('English NIV', ': ', lVerse),

                          const SizedBox(height: 8.0),
                        ],
                      );
                    }),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    detailController.updateshowSelectionMenu(false);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'close'.tr,
                    style:
                        TextStyle(color: themeData.themeData.value!.verseColor),
                  ),
                ),
              ],
            );
          }
        });
  }

  Widget buildVerseContainer(String title, String separ, Verses lverse) {
    // if(detailController.selectedBook != 'አዲሱ መደበኛ ትርጉም'){

    // }
    String chapterNameIs = detailController.selectedBook.contains('Eng')
        ? detailController
            .getAMHBookinfo(detailController.getBookTitle(lverse.book!))
        : detailController.getBookTitle(lverse.book!);

    List<String> listof = detailController.selectedBook != Keys.defaultbibleName
        ? spnKJVverseText
        : detailController.selectedBook != Keys.secondbibleName
            ? aMHNIVverseText
            : detailController.selectedBook != 'English KJV'
                ? eNGKJVverseText
                : detailController.selectedBook != 'English NIV'
                    ? eNGNIVverseText
                    : [];
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$title - $chapterNameIs ${lverse.chapter!}:${lverse.verseNumber!}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
            shrinkWrap: true,
            itemCount: listof.length,
            itemBuilder: (context, index) {
              var lVerse = widget.selectedVerses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${lVerse.verseNumber!}$separ',
                        style: TextStyle(
                          fontSize: detailController.fontSize.sp,
                          color: themeData.themeData.value!.numbersColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: lVerse.verseText,
                        style: TextStyle(
                          fontSize: detailController.fontSize.sp,
                          color: themeData.themeData.value!.verseColor,
                          fontFamily: "Abyssinica",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
