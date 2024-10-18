import 'package:emicalculator/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/pre_loade_industrial_ad_first_service.dart';
import '../../widgets/app.button.dart';
import '../age_and_gender_selection_screen/age_and_gender_selection_view.dart';
import '../select_calculator_screen/select_calculator_view.dart';
import 'on_boarding_three_view_controller.dart';

class OnBoardingTreeView extends StatelessWidget {
  const OnBoardingTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<OnBoardingThreeViewController>(OnBoardingThreeViewController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        if (!controller.isOnlyShowApp.value) {
          PreLoadIndustrialAdFirstService.to.showInterstitialAd();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.black100,
        body: Stack(
          children: [
            StreamBuilder(
              stream: OnBoardingThreeViewController.to.isAdLoaded.stream,
              builder: (context, snapshot) {
                return OnBoardingThreeViewController.to.bannerAd == null
                    ? const SizedBox()
                    : SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: double.maxFinite,
                            height: OnBoardingThreeViewController
                                .to.bannerAd!.size.height
                                .toDouble(),
                            child: AdWidget(
                              ad: OnBoardingThreeViewController.to.bannerAd!,
                            ),
                          ),
                        ),
                      ).paddingOnly(top: 10);
              },
            ),
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
                    "Smart Loan\nEmi Planning",
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
                      bool value =
                          !OnBoardingThreeViewController.to.isOnlyShowApp.value;
                      if (!value) {
                        Get.to(const SelectCalculatorView());
                      } else {
                        Get.to(const AgeAndGenderSelectionView());
                        PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                      }
                    },
                  ),
                ],
              ).paddingOnly(bottom: 80),
            ),
          ],
        ),
      ),
    );
  }
}
