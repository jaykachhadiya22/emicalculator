import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/remote_config_response_data_model.dart';
import 'firebase_remote_config_data_service.dart';

class LoadNativeBannerAdService {
  static LoadNativeBannerAdService get to =>
      Get.find<LoadNativeBannerAdService>();

  InterstitialAd? interstitialAd;
  bool isInterstitialAdReady = false;

  Future<void> loadInterstitialAd() async {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    await InterstitialAd.load(
      adUnitId: value.bannerAdId,
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
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    if (isInterstitialAdReady) {
      interstitialAd?.show();
    } else {
      loadInterstitialAd();
      debugPrint('Interstitial ad is not ready yet.');
    }
  }
}
