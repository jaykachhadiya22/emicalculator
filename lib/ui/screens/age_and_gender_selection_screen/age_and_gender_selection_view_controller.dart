import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AgeAndGenderSelectionViewController extends GetxController {
  static AgeAndGenderSelectionViewController get to =>
      Get.find<AgeAndGenderSelectionViewController>();

  List<int> ageList = List<int>.generate(65, (index) => index + 16);
  RxInt currentCenterItem = 4.obs;
  Rx<String> selectedGender = "Male".obs;

  onGenderButtonTap(String value) {
    selectedGender.value = value;
    selectedGender.refresh();
  }

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
