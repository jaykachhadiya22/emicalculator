import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/pre_loade_industrial_ad_first_service.dart';
import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import '../select_calculator_screen/select_calculator_view.dart';
import 'how_many_days_loan_needs_view_controller.dart';

class HowManyDaysLoanNeedsView extends StatelessWidget {
  const HowManyDaysLoanNeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<HowManyDaysLoanNeedsViewController>(
        HowManyDaysLoanNeedsViewController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        PreLoadIndustrialAdFirstService.to.showInterstitialAd();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.black100,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Gap(40),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Loan Duration",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "What is the duration for which you require the loan?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black30,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(30),
                  AppButton(
                    "3 Month",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "6 Month",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "1 Year",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "3 Years",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "10 Years",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Greater than 20 years",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const SelectCalculatorView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream:
                        HowManyDaysLoanNeedsViewController.to.isAdLoaded.stream,
                    builder: (context, snapshot) {
                      return HowManyDaysLoanNeedsViewController.to.bannerAd ==
                              null
                          ? const SizedBox()
                          : SafeArea(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: double.maxFinite,
                                height: HowManyDaysLoanNeedsViewController
                                    .to.bannerAd!.size.height
                                    .toDouble(),
                                child: AdWidget(
                                  ad: HowManyDaysLoanNeedsViewController
                                      .to.bannerAd!,
                                ),
                              ),
                            ).paddingOnly(top: 10);
                    },
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
