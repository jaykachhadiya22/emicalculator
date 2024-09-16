import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OnBoardingFirstViewController extends GetxController {
  static OnBoardingFirstViewController get to =>
      Get.find<OnBoardingFirstViewController>();

  BannerAd? bannerAd;
  RxBool isAdLoaded = false.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await loadBannerAd();
    super.onInit();
  }

  loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
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
