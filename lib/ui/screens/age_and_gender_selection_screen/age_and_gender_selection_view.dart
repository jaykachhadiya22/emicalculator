import 'package:carousel_slider/carousel_slider.dart';
import 'package:emicalculator/ui/screens/age_and_gender_selection_screen/age_and_gender_selection_view_controller.dart';
import 'package:emicalculator/ui/screens/credit_score_screen/credit_score_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';

class AgeAndGenderSelectionView extends StatelessWidget {
  const AgeAndGenderSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Select your Age",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Gap(40),
              CreditSliderView(
                creditList: AgeAndGenderSelectionViewController.to.ageList,
              ),
              const Gap(50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Select Your Gender",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Gap(40),
              StreamBuilder(
                  stream: AgeAndGenderSelectionViewController
                      .to.selectedGender.stream,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => AgeAndGenderSelectionViewController.to
                              .onGenderButtonTap("Male"),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  "assets/images/male_avtar.png",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(20),
                              Text(
                                "Male",
                                style: TextStyle(
                                  color: AgeAndGenderSelectionViewController
                                              .to.selectedGender.value ==
                                          "Male"
                                      ? AppColors.orange
                                      : AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AgeAndGenderSelectionViewController.to
                              .onGenderButtonTap("Female"),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  "assets/images/female_avtar.jpg",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(20),
                              Text(
                                "Female",
                                style: TextStyle(
                                  color: AgeAndGenderSelectionViewController
                                              .to.selectedGender.value ==
                                          "Female"
                                      ? AppColors.orange
                                      : AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              const Spacer(),
              AppButton(
                "Next",
                buttonTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const CreditScoreView()),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditSliderView extends StatelessWidget {
  final List<int> creditList;

  const CreditSliderView({
    super.key,
    required this.creditList,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AgeAndGenderSelectionViewController.to.currentCenterItem.stream,
      builder: (context, snapshot) {
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 60,
            animateToClosest: true,
            viewportFraction: 0.2,
            pageSnapping: true,
            enableInfiniteScroll: false,
            initialPage: 4,
            onPageChanged: (index, reason) {
              AgeAndGenderSelectionViewController.to.currentCenterItem.value =
                  index;
            },
          ),
          itemCount: creditList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: (index ==
                        AgeAndGenderSelectionViewController
                            .to.currentCenterItem.value)
                    ? AppColors.black80
                    : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x25000000),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  creditList[index].toString(),
                  style: TextStyle(
                    color: (index ==
                            AgeAndGenderSelectionViewController
                                .to.currentCenterItem.value)
                        ? AppColors.orange
                        : AppColors.black40,
                    fontSize: index ==
                            AgeAndGenderSelectionViewController
                                .to.currentCenterItem.value
                        ? 30
                        : 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
