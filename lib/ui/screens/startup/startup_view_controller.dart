import 'package:emicalculator/ui/screens/no_data_found_screen/no_data_found_view.dart';
import 'package:emicalculator/ui/screens/on_bording_first_screen/on_boarding_first_view.dart';
import 'package:emicalculator/ui/screens/select_calculator_screen/select_calculator_view.dart';
import 'package:get/get.dart';

import '../../../data/remote_config_response_data_model.dart';
import '../../../services/app_open_ad_manager_service.dart';
import '../../../services/firebase_remote_config_data_service.dart';

class StartupViewController extends GetxController {
  static StartupViewController get to => Get.find<StartupViewController>();

  navigateAndShowAd() async {
    RemoteConfigResponseDataModel? value =
        FirebaseRemoteConfigDataService.to.responseDataModel;
    if (value == null) {
      await Future.delayed(const Duration(milliseconds: 200));
      Get.offAll(const NoDataFoundView());
      return;
    }
    AppOpenAdManagerService.to.showAdIfAvailable();
    if (value.isOnlyShowApp) {
      await Future.delayed(const Duration(milliseconds: 200));
      Get.offAll(const SelectCalculatorView());
    } else {
      await Future.delayed(const Duration(milliseconds: 200));
      Get.offAll(const OnBoardingFirstView());
    }
  }
}
