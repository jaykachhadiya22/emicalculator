import 'package:emicalculator/ui/screens/select_calculator_screen/select_calculator_view.dart';
import 'package:get/get.dart';

import '../../../services/app_open_ad_manager_service.dart';

class StartupViewController extends GetxController {
  static StartupViewController get to => Get.find<StartupViewController>();

  navigateAndShowAd() async {
    AppOpenAdManagerService.to.showAdIfAvailable();
    await Future.delayed(const Duration(milliseconds: 200));
    Get.offAll(const SelectCalculatorView());
  }
}
