import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(String storeId,
      {bool short = true}) async {
    String _linkMessage;
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://connectuz.page.link',
      link: Uri.parse('https://connectuz.com/store?store_id=$storeId'),
      androidParameters: AndroidParameters(
        packageName: 'com.connectuz.user',
        minimumVersion: 21,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    _linkMessage = url.toString();
    return _linkMessage;
  }
}
