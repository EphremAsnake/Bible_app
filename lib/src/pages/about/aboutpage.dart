// import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
// import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
// import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
// import 'package:bible_book_app/app/utils/shared_widgets/custom_progress_indicator.dart';
// import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// import '../controllers/about_controller.dart';

// class AboutView extends GetView<AboutController> {
//   AboutView({Key? key}) : super(key: key);
//   final themeData = Get.find<ThemeController>().themeData.value;
//   final DetailController detailController = Get.find<DetailController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: Color(0xff7B5533),
//             statusBarIconBrightness: Brightness.light),
//         elevation: 0,
//         backgroundColor: const Color(0xff7B5533),
//         title: Text(
//           'about'.tr,
//           style: const TextStyle(color: Colors.white),
//         ),
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: themeData!.whiteColor),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: GetBuilder<DetailController>(
//           init: DetailController(),
//           initState: (_) {},
//           builder: (_) {
//             if (detailController.apiStateHandler.apiState == ApiState.loading) {
//               return const Center(
//                 child: CustomProgressIndicator(),
//               );
//             } else if (detailController.apiStateHandler.apiState ==
//                 ApiState.success) {
//               return Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: SizedBox(
//                           height: 86.h,
//                           child: Card(
//                             elevation: 0,
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10.0, vertical: 10.0.sp),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Center(
//                                       child: Text(
//                                         detailController
//                                             .apiStateHandler.data!.aboutApp,
//                                         textAlign: TextAlign.justify,
//                                         style: TextStyle(
//                                             color: themeData?.blackColor,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else if (detailController.apiStateHandler.apiState ==
//                 ApiState.error) {
//               return RefreshErrorWidget(
//                 showBackToHomeButton: true,
//                 assetImage: "assets/images/error.png",
//                 errorMessage: detailController.apiStateHandler.error!,
//                 onRefresh: () async {
//                   detailController.fetchConfigsData();
//                   detailController.update();
//                 },
//               );
//             } else {
//               return RefreshErrorWidget(
//                 showBackToHomeButton: true,
//                 assetImage: "assets/images/error.png",
//                 errorMessage:
//                     "No internet connection, please check your internet connection and try again.",
//                 onRefresh: () async {
//                   detailController.fetchConfigsData();
//                   detailController.update();
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
