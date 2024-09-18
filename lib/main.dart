import 'package:emicalculator/services/app_open_ad_manager_service.dart';
import 'package:emicalculator/services/pre_loade_industrial_ad_first_service.dart';
import 'package:emicalculator/ui/screens/startup/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/app.bindings.dart';
import 'data/local/get_storage.dart';

Future<void> main() async {
  var devices = [
    "FEFB761BA483F7737E64F2AA08C14616",
    "66EF7F968129459770DF7F4C81B69035"
  ];
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();

  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    Get.put<AppOpenAdManagerService>(AppOpenAdManagerService());
    Get.put<PreLoadIndustrialAdFirstService>(PreLoadIndustrialAdFirstService());
    Get.put<GetStorageService>(GetStorageService());
    await AppOpenAdManagerService.to.loadAd();
    await PreLoadIndustrialAdFirstService.to.loadInterstitialAd();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Loan Emi Calc",
      initialBinding: AppBindings(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const StartupView(),
    );
  }
}
