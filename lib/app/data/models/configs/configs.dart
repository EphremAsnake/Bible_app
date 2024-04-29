import 'dart:convert';

Configs configsFromJson(String str) => Configs.fromJson(json.decode(str));

String configsToJson(Configs data) => json.encode(data.toJson());

class Configs {
  List<HouseAd> androidHouseAds;
  List<HouseAd> iosHouseAds;
  String aboutApp;

  Configs({
    required this.androidHouseAds,
    required this.iosHouseAds,
    required this.aboutApp,
  });

  factory Configs.fromJson(Map<String, dynamic> json) => Configs(
        androidHouseAds: List<HouseAd>.from(
            json["android_house_ads"].map((x) => HouseAd.fromJson(x))),
        iosHouseAds: List<HouseAd>.from(
            json["ios_house_ads"].map((x) => HouseAd.fromJson(x))),
        aboutApp: json["about_app"],
      );

  Map<String, dynamic> toJson() => {
        "android_house_ads":
            List<dynamic>.from(androidHouseAds.map((x) => x.toJson())),
        "ios_house_ads": List<dynamic>.from(iosHouseAds.map((x) => x.toJson())),
        "about_app": aboutApp,
      };
}

class HouseAd {
  HouseAd1? houseAd1;
  HouseAd2? houseAd2;

  HouseAd({
    this.houseAd1,
    this.houseAd2,
  });

  factory HouseAd.fromJson(Map<String, dynamic> json) => HouseAd(
        houseAd1: json["house_ad_1"] == null
            ? null
            : HouseAd1.fromJson(json["house_ad_1"]),
        houseAd2: json["house_ad_2"] == null
            ? null
            : HouseAd2.fromJson(json["house_ad_2"]),
      );

  Map<String, dynamic> toJson() => {
        "house_ad_1": houseAd1?.toJson(),
        "house_ad_2": houseAd2?.toJson(),
      };
}

class HouseAd1 {
  String image;
  bool show;
  bool openInAppBrowser;
  String url;

  HouseAd1({
    required this.image,
    required this.show,
    required this.openInAppBrowser,
    required this.url,
  });

  factory HouseAd1.fromJson(Map<String, dynamic> json) => HouseAd1(
        image: json["image"],
        show: json["show"],
        openInAppBrowser: json["open_in_app_browser"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "show": show,
        "open_in_app_browser": openInAppBrowser,
        "url": url,
      };
}

class HouseAd2 {
  String title;
  String buttonText;
  bool show;
  bool openInAppBrowser;
  String url;

  HouseAd2({
    required this.title,
    required this.buttonText,
    required this.show,
    required this.openInAppBrowser,
    required this.url,
  });

  factory HouseAd2.fromJson(Map<String, dynamic> json) => HouseAd2(
        title: json["title"],
        buttonText: json["button_text"],
        show: json["show"],
        openInAppBrowser: json["open_in_app_browser"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "button_text": buttonText,
        "show": show,
        "open_in_app_browser": openInAppBrowser,
        "url": url,
      };
}
