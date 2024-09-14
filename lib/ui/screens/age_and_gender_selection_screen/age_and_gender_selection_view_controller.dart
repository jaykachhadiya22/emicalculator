import 'package:get/get.dart';

class AgeAndGenderSelectionViewController extends GetxController {
  static AgeAndGenderSelectionViewController get to =>
      Get.find<AgeAndGenderSelectionViewController>();

  List<int> ageList = List<int>.generate(65, (index) => index + 16);
  RxInt currentCenterItem = 4.obs;
  Rx<String> selectedGender = "Male".obs;

  onGenderButtonTap(String value) {
    selectedGender.value = value;
    selectedGender.refresh();
  }
}
