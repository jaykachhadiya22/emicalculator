import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../data/remote_config_response_data_model.dart';
import '../../../services/firebase_remote_config_data_service.dart';

class OnBoardingFirstViewController extends GetxController {
  static OnBoardingFirstViewController get to =>
      Get.find<OnBoardingFirstViewController>();

  BannerAd? bannerAd;
  RxBool isAdLoaded = false.obs;
  RxBool isOnlyShowApp = true.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    isOnlyShowApp.value = value?.isOnlyShowApp ?? true;
    if (!isOnlyShowApp.value) {
      await loadBannerAd();
    }
    super.onInit();
  }

  loadBannerAd() {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;

    if (value == null) return;
    bannerAd = BannerAd(
      adUnitId: value.bannerAdId,
      size: const AdSize(width: 468, height: 60),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          Future.delayed(
            const Duration(seconds: 5),
            () {
              loadBannerAd();
            },
          );
        },
      ),
    )..load();
  }
}
