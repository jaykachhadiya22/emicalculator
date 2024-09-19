import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/remote_config_response_data_model.dart';
import 'app_open_ad_manager_service.dart';
import 'firebase_remote_config_data_service.dart';

class PreLoadIndustrialAdFirstService with WidgetsBindingObserver {
  static PreLoadIndustrialAdFirstService get to =>
      Get.find<PreLoadIndustrialAdFirstService>();

  InterstitialAd? interstitialAd;
  bool isInterstitialAdReady = false;

  Future<void> loadInterstitialAd() async {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    await InterstitialAd.load(
      adUnitId: value.industrialAdId,
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
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) return;
    if (isInterstitialAdReady) {
      interstitialAd?.show();
      await Future.delayed(const Duration(seconds: 2));
      WidgetsBinding.instance.removeObserver(this);
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
