import 'package:get/get.dart';

import '../../../services/app_open_ad_manager_service.dart';
import '../on_bording_first_screen/on_boarding_first_view.dart';

class StartupViewController extends GetxController {
  static StartupViewController get to => Get.find<StartupViewController>();

  navigateAndShowAd() async {
    AppOpenAdManagerService.to.showAdIfAvailable();
    await Future.delayed(const Duration(milliseconds: 200));
    Get.offAll(const OnBoardingFirstView());
  }
}
