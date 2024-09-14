import 'package:emicalculator/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/app.button.dart';
import '../age_and_gender_selection_screen/age_and_gender_selection_view.dart';

class OnBoardingTreeView extends StatelessWidget {
  const OnBoardingTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              "assets/icons/budget_calculator.svg",
              height: 210,
              width: 210,
            ),
          ).paddingOnly(top: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Smart\nLoan Planning",
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
                const Gap(10),
                const Text(
                  "Calculate your EMI and plan your repayments easily.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const Gap(60),
                AppButton(
                  "Get Started",
                  height: 60,
                  width: 200,
                  borderRadius: BorderRadius.circular(25),
                  appIcon: SvgPicture.asset(
                    "assets/icons/right_arrow.svg",
                    height: 12,
                    width: 12,
                  ).paddingOnly(bottom: 5),
                  buttonTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Get.to(const AgeAndGenderSelectionView());
                  },
                ),
              ],
            ).paddingOnly(bottom: 80),
          ),
        ],
      ),
    );
  }
}
