import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../data/api/api_client.dart';
import '../util/app_constants.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(String storeId,
      {bool short = true}) async {
    String _linkMessage;

    ApiClient apiClient = Get.find();
    String url = AppConstants.getSharableLink + storeId;
    var response = await apiClient.getData(url);
    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> data = response.body;
      _linkMessage = data['shortLink'] ?? "try again...";
    } else {
      print("Error while generating link");
      print(response);
      _linkMessage = "error while generarting link.";
    }

    return _linkMessage;
  }
}
