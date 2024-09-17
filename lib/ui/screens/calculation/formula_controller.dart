import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FormulaController extends GetxController {
  static FormulaController get to => Get.find<FormulaController>();

  BannerAd? bannerAd;
  RxBool isAdLoaded = false.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await loadBannerAd();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bannerAd?.dispose();
    super.dispose();
  }

  loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: const AdSize(width: 320, height: 250),
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
