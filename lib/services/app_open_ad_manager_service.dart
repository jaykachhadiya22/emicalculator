import 'package:emicalculator/services/firebase_remote_config_data_service.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/remote_config_response_data_model.dart';

class AppOpenAdManagerService {
  static AppOpenAdManagerService get to => Get.find<AppOpenAdManagerService>();
  AppOpenAd? _appOpenAd;
  bool isAdShowing = false;
  RxBool isAdAvailable = false.obs;

  Future<void> loadAd() async {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    await AppOpenAd.load(
      adUnitId: value.appOpenAdId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          isAdAvailable.value = true;
        },
        onAdFailedToLoad: (error) {
          print("GOOGLE AD LOADE PROBLEM  : ${error}");
          isAdAvailable.value = false;
        },
      ),
    );
  }

  void showAdIfAvailable() {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    if (isAdAvailable.value && !isAdShowing) {
      _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          isAdShowing = false;
          _appOpenAd = null;
          loadAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          isAdShowing = false;
        },
        onAdShowedFullScreenContent: (ad) {
          isAdShowing = true;
        },
      );
      _appOpenAd?.show();
    } else {
      loadAd();
    }
  }
}
