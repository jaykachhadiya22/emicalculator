import 'package:emicalculator/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/pre_loade_industrial_ad_first_service.dart';
import '../../widgets/app.button.dart';
import '../on_bording_three_screen/on_boarding_three_view.dart';
import 'on_boarding_two_view_controller.dart';

class OnBoardingTwoView extends StatelessWidget {
  const OnBoardingTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<OnBoardingTwoViewController>(OnBoardingTwoViewController());
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: OnBoardingTwoViewController.to.isAdLoaded.stream,
                builder: (context, snapshot) {
                  return OnBoardingTwoViewController.to.bannerAd == null
                      ? const SizedBox()
                      : SafeArea(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: double.maxFinite,
                            height: OnBoardingTwoViewController
                                .to.bannerAd!.size.height
                                .toDouble(),
                            child: AdWidget(
                              ad: OnBoardingTwoViewController.to.bannerAd!,
                            ),
                          ),
                        ).paddingOnly(top: 10);
                },
              ),
              !OnBoardingTwoViewController.to.isOnlyShowApp.value
                  ? const SizedBox()
                  : const Gap(150),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/icons/car.svg",
                  height: 210,
                  width: 210,
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Online\nDigital Loan",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      "Calculate EMIs, compare loans, and take control of your budget",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    const Gap(60),
                    AppButton(
                      "Next",
                      height: 60,
                      width: 150,
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
                        Get.to(const OnBoardingTreeView());
                        if (!OnBoardingTwoViewController
                            .to.isOnlyShowApp.value) {
                          PreLoadIndustrialAdFirstService.to
                              .showInterstitialAd();
                        }
                      },
                    ),
                  ],
                ).paddingOnly(bottom: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
