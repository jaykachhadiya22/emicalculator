import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app_open_ad_manager_service.dart';

class PreLoadIndustrialAdFirstService with WidgetsBindingObserver {
  static PreLoadIndustrialAdFirstService get to =>
      Get.find<PreLoadIndustrialAdFirstService>();

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
            onAdDismissedFullScreenContent: (InterstitialAd ad) async {
              ad.dispose();
              loadInterstitialAd();
              await Future.delayed(const Duration(seconds: 2));
              WidgetsBinding.instance.addObserver(this);
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          loadInterstitialAd();
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (isInterstitialAdReady) {
      WidgetsBinding.instance.removeObserver(this);
      interstitialAd?.show();
    } else {
      loadInterstitialAd();
      debugPrint('Interstitial ad is not ready yet.');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppOpenAdManagerService.to.showAdIfAvailable();
    }
  }
}
