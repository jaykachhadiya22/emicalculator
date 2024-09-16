import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LoadNativeBannerAdService {
  static LoadNativeBannerAdService get to =>
      Get.find<LoadNativeBannerAdService>();

  InterstitialAd? interstitialAd;
  bool isInterstitialAdReady = false;

  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isInterstitialAdReady = true;

          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (isInterstitialAdReady) {
      interstitialAd?.show();
    } else {
      loadInterstitialAd();
      debugPrint('Interstitial ad is not ready yet.');
    }
  }
}
