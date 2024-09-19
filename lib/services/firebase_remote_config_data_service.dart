import 'dart:convert';

import 'package:emicalculator/data/remote_config_response_data_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirebaseRemoteConfigDataService {
  static FirebaseRemoteConfigDataService get to =>
      Get.find<FirebaseRemoteConfigDataService>();

  final remoteConfig = FirebaseRemoteConfig.instance;
  RemoteConfigResponseDataModel? responseDataModel;

  Future<void> initialize() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Remote Config fetch failed: $e');
    }
  }

  getRemoteConfigData() {
    String welcomeMessage = remoteConfig.getString('appData');
    responseDataModel = RemoteConfigResponseDataModel.fromJson(jsonDecode(welcomeMessage));
  }
}
