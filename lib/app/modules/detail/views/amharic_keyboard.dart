import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/shared_controllers/theme_controller.dart';

class AmharicLetter {
  final String basicForm;
  final List<String> forms;

  AmharicLetter(this.basicForm, this.forms);
}

final DetailController detailController = Get.find();
final ThemeController themeData = Get.find<ThemeController>();

class AmharicKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        return Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Container(
              color: themeData.themeData.value!.keyboardColor,
              padding: const EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: detailController
                              .selectedAmharicLetter?.forms.isNotEmpty ??
                          false,
                      child: Padding(
                        padding: SizerUtil.deviceType != DeviceType.mobile
                            ? const EdgeInsets.fromLTRB(4.0, 0, 4, 10)
                            : const EdgeInsets.all(0),
                        child: SizedBox(
                          height: SizerUtil.deviceType == DeviceType.mobile
                              ? 6.5.h
                              : 5.4.h,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 1),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: detailController
                                .selectedAmharicLetter?.forms.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: detailController
                                          .selectedAmharicLetter?.basicForm ==
                                      '0'
                                  ? 10
                                  : 7,
                              mainAxisSpacing: 4.0, // Adjust the spacing here
                              crossAxisSpacing: 5.0, // Adjust the spacing here
                            ),
                            itemBuilder: (context, index) {
                              final key = detailController
                                  .selectedAmharicLetter?.forms[index];
                              return InkWell(
                                onTap: () {
                                  if (detailController
                                          .isKeyboardFormIsPressedFromBasicForm ==
                                      true) {
                                    bool isFirstForm = false;
                                    int currentlySelectedKeyIndex =
                                        _keyboardRows.indexOf(detailController
                                            .selectedAmharicLetter!);
                                    AmharicLetter letter = _keyboardRows[
                                        currentlySelectedKeyIndex];
                                    List<String> inputValues = detailController
                                        .searchController.text
                                        .split('');

                                    if (inputValues.isNotEmpty) {
                                      if (letter.basicForm ==
                                          inputValues[inputValues.length - 1]) {
                                        isFirstForm = true;
                                      }

                                      if (isFirstForm == true) {
                                        inputValues[inputValues.length - 1] =
                                            key!;
                                        String inputValue = inputValues.join();
                                        detailController.searchController.text =
                                            inputValue;
                                        detailController.update();
                                      } else {
                                        detailController.onKeyPressed(key!);
                                      }
                                    }
                                    detailController
                                            .isKeyboardFormIsPressedFromBasicForm =
                                        false;
                                    detailController.update();
                                  } else {
                                    detailController.onKeyPressed(key!);
                                    detailController
                                            .isKeyboardFormIsPressedFromBasicForm =
                                        false;
                                    detailController.update();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeData
                                        .themeData.value!.backgroundColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    //!padding: const EdgeInsets.only(bottom:10.0),
                                    padding: const EdgeInsets.only(bottom:0.0),
                                    child: Text(
                                      key ?? "",
                                      style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 10.sp
                                              : 16.0,
                                          color: themeData
                                              .themeData.value!.verseColor),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 27.h
                          : 21.h,
                      child: Wrap(
                        spacing: SizerUtil.deviceType == DeviceType.mobile
                            ? 5.0
                            : 4.0, // Adjust the spacing here
                        runSpacing: SizerUtil.deviceType == DeviceType.mobile
                            ? 5.0
                            : 4.0, // Adjust the run spacing here
                        children: _keyboardRows.map((key) {
                          return SizedBox(
                            width: SizerUtil.deviceType == DeviceType.mobile
                                ? key.basicForm == '―'
                                    ? 98.sp
                                    : 30.sp
                                : key.basicForm == '―'
                                    ? 74.8.sp
                                    : 24.sp,
                            height: 40,
                            child: InkWell(
                              onTap: () async {
                                if (key.basicForm == "EN") {
                                  detailController.openEnglishKeyboard();
                                  FocusScope.of(context)
                                      .requestFocus(detailController.focusNode);
                                } else if (key.basicForm == '←') {
                                  detailController.onBackSpaceKeyPressed();
                                } else if (key.basicForm == '🔎') {
                                  if (detailController
                                      .searchController.text.isNotEmpty) {
                                    detailController.updateforsearch(
                                        detailController.searchController.text);
                                    await EasyLoading.show(
                                        status: 'Searching Please Wait...');
                                    detailController.searchResultVerses =
                                        await detailController.search(
                                            BibleType: detailController
                                                .selectedBookTypeOptions,
                                            searchType: detailController
                                                .selectedSearchTypeOptions,
                                            searchPlace: detailController
                                                .selectedSearchPlaceOptions,
                                            query: detailController
                                                .searchController.text);
                                    detailController.isAmharicKeyboardVisible =
                                        false;

                                    EasyLoading.dismiss();
                                    detailController.update();
                                  }
                                } else if (key.basicForm == '↓') {
                                  detailController
                                      .makeAmharicKeyboardInVisible();
                                } else if (key.basicForm == '―') {
                                  detailController.onKeyPressed(" ");
                                } else if (key.basicForm == '@') {
                                  detailController.onKeyPressed(key.basicForm);
                                } else {
                                  detailController
                                      .setSelectedAmharicLetter(key);
                                  detailController
                                          .isKeyboardFormIsPressedFromBasicForm =
                                      true;
                                  detailController.onKeyPressed(key.basicForm);
                                  detailController.update();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: themeData
                                      .themeData.value!.backgroundColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  key.basicForm,
                                  style: TextStyle(
                                      fontSize: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 10.sp
                                          : 16.0,
                                      color: themeData
                                          .themeData.value!.verseColor),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
}

final List<AmharicLetter> _keyboardRows = [
  AmharicLetter('ሀ', ['ሀ', 'ሁ', 'ሂ', 'ሃ', 'ሄ', 'ህ', 'ሆ']),
  AmharicLetter('ለ', ['ለ', 'ሉ', 'ሊ', 'ላ', 'ሌ', 'ል', 'ሎ']),
  AmharicLetter('ሐ', ['ሐ', 'ሑ', 'ሒ', 'ሓ', 'ሔ', 'ሕ', 'ሖ']),
  AmharicLetter('መ', ['መ', 'ሙ', 'ሚ', 'ማ', 'ሜ', 'ም', 'ሞ']),
  AmharicLetter('ሠ', ['ሠ', 'ሡ', 'ሢ', 'ሣ', 'ሤ', 'ሥ', 'ሦ']),
  AmharicLetter('ረ', ['ረ', 'ሩ', 'ሪ', 'ራ', 'ሬ', 'ር', 'ሮ']),
  AmharicLetter('ሰ', ['ሰ', 'ሱ', 'ሲ', 'ሳ', 'ሴ', 'ስ', 'ሶ']),
  AmharicLetter('ሸ', ['ሸ', 'ሹ', 'ሺ', 'ሻ', 'ሼ', 'ሽ', 'ሾ']),
  AmharicLetter('ቀ', ['ቀ', 'ቁ', 'ቂ', 'ቃ', 'ቄ', 'ቅ', 'ቆ']),
  AmharicLetter('በ', ['በ', 'ቡ', 'ቢ', 'ባ', 'ቤ', 'ብ', 'ቦ']),
  AmharicLetter('ተ', ['ተ', 'ቱ', 'ቲ', 'ታ', 'ቴ', 'ት', 'ቶ']),
  AmharicLetter('ቸ', ['ቸ', 'ቹ', 'ቺ', 'ቻ', 'ቼ', 'ች', 'ቾ']),
  AmharicLetter('ኀ', ['ኀ', 'ኁ', 'ኂ', 'ኃ', 'ኄ', 'ኅ', 'ኆ']),
  AmharicLetter('ነ', ['ነ', 'ኑ', 'ኒ', 'ና', 'ኔ', 'ን', 'ኖ']),
  AmharicLetter('ኘ', ['ኘ', 'ኙ', 'ኚ', 'ኛ', 'ኜ', 'ኝ', 'ኞ']),
  AmharicLetter('አ', ['አ', 'ኡ', 'ኢ', 'ኣ', 'ኤ', 'እ', 'ኦ']),
  AmharicLetter('ከ', ['ከ', 'ኩ', 'ኪ', 'ካ', 'ኬ', 'ክ', 'ኮ']),
  AmharicLetter('ኸ', ['ኸ', 'ኹ', 'ኺ', 'ኻ', 'ኼ', 'ኽ', 'ኾ']),
  AmharicLetter('ወ', ['ወ', 'ዉ', 'ዊ', 'ዋ', 'ዌ', 'ው', 'ዎ']),
  AmharicLetter('ዐ', ['ዐ', 'ዑ', 'ዒ', 'ዓ', 'ዔ', 'ዕ', 'ዖ']),
  AmharicLetter('ዘ', ['ዘ', 'ዙ', 'ዚ', 'ዛ', 'ዜ', 'ዝ', 'ዞ']),
  AmharicLetter('ዠ', ['ዠ', 'ዡ', 'ዢ', 'ዣ', 'ዤ', 'ዥ', 'ዦ']),
  AmharicLetter('የ', ['የ', 'ዩ', 'ዪ', 'ያ', 'ዬ', 'ይ', 'ዮ']),
  AmharicLetter('ደ', ['ደ', 'ዱ', 'ዲ', 'ዳ', 'ዴ', 'ድ', 'ዶ']),
  AmharicLetter('ጀ', ['ጀ', 'ጁ', 'ጂ', 'ጃ', 'ጄ', 'ጅ', 'ጆ']),
  AmharicLetter('ገ', ['ገ', 'ጉ', 'ጊ', 'ጋ', 'ጌ', 'ግ', 'ጎ']),
  AmharicLetter('ጠ', ['ጠ', 'ጡ', 'ጢ', 'ጣ', 'ጤ', 'ጥ', 'ጦ']),
  AmharicLetter('ጨ', ['ጨ', 'ጩ', 'ጪ', 'ጫ', 'ጬ', 'ጭ', 'ጮ']),
  AmharicLetter('ጰ', ['ጰ', 'ጱ', 'ጲ', 'ጳ', 'ጴ', 'ጵ', 'ጶ']),
  AmharicLetter('ጸ', ['ጸ', 'ጹ', 'ጺ', 'ጻ', 'ጼ', 'ጽ', 'ጾ']),
  AmharicLetter('ፀ', ['ፀ', 'ፁ', 'ፂ', 'ፃ', 'ፄ', 'ፅ', 'ፆ']),
  AmharicLetter('ፈ', ['ፈ', 'ፉ', 'ፊ', 'ፋ', 'ፌ', 'ፍ', 'ፎ']),
  AmharicLetter('ፐ', ['ፐ', 'ፑ', 'ፒ', 'ፓ', 'ፔ', 'ፕ', 'ፖ']),
  AmharicLetter('EN', []),
  AmharicLetter('―', []),
  AmharicLetter('←', []),
  AmharicLetter('↓', []),
  AmharicLetter('🔎', []),
];
