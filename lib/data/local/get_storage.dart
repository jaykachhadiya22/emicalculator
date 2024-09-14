import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../const/app_const.dart';

GetStorage storage = GetStorage();

class GetStorageService {
  static GetStorageService get to => Get.find<GetStorageService>();

  saveAccessToken(String value) async {
    try {
      await storage.write(AppConst.accessToken, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  String getAccessToken() {
    try {
      String? resultInString = storage.read(AppConst.accessToken);
      if (resultInString == null) return "";
      return resultInString;
    } catch (e) {
      return "";
    }
  }

  clearSharedPreference() async {
    try {
      await storage.erase();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
