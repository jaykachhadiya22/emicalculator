import 'package:emicalculator/ui/screens/age_and_gender_selection_screen/age_and_gender_selection_view_controller.dart';
import 'package:emicalculator/ui/screens/startup/startup_view_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<StartupViewController>(
      StartupViewController(),
      permanent: true,
    );
    Get.put<AgeAndGenderSelectionViewController>(
      AgeAndGenderSelectionViewController(),
      permanent: true,
    );
  }
}
