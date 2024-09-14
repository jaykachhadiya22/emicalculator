import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManagerService {
  static AppOpenAdManagerService get to => Get.find<AppOpenAdManagerService>();
  AppOpenAd? _appOpenAd;
  bool isAdShowing = false;
  RxBool isAdAvailable = false.obs;

  Future<void> loadAd() async {
   await AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/9257395921',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("AS LODADED : ${ad}");
          _appOpenAd = ad;
          isAdAvailable.value = true;
          // showAdIfAvailable();
        },
        onAdFailedToLoad: (error) {
          print("AD LOADE ERROR : ${error}");
          isAdAvailable.value = false;
        },
      ),
    );
  }

  void showAdIfAvailable() {
    print("Hello wored : ${isAdAvailable} ${!isAdShowing}");
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
