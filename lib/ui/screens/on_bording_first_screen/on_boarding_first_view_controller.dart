import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/app_open_ad_manager_service.dart';

class OnBoardingFirstViewController extends GetxController {
  static OnBoardingFirstViewController get to =>
      Get.find<OnBoardingFirstViewController>();

  RxBool isAdLoaded = false.obs;
  InterstitialAd? _interstitialAd;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    // loadInterstitialAd();
    super.onInit();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          isAdLoaded.value = true;
          _interstitialAd?.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load an interstitial ad: ${error.message}');
          isAdLoaded.value = false;
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }
}
