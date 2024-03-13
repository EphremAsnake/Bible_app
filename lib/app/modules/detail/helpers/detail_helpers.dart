import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHelpers {
  openStores({String? androidAppId, String? iOSAppId}) {
    try {
      StoreRedirect.redirect(androidAppId: androidAppId, iOSAppId: iOSAppId);
    } catch (ex) {}
  }

  Future<void> launchWebUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch');
    }
  }
}