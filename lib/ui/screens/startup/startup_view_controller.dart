import 'package:emicalculator/ui/screens/on_bording_first_screen/on_boarding_first_view.dart';
import 'package:get/get.dart';

class StartupViewController extends GetxController {
  static StartupViewController get to => Get.find<StartupViewController>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(const OnBoardingFirstView());

    super.onInit();
  }
}
