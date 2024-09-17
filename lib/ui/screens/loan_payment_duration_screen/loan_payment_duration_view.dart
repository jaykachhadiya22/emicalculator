import 'package:emicalculator/ui/screens/loan_payment_duration_screen/loan_payment_duration_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/pre_loade_industrial_ad_first_service.dart';
import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import '../how_many_days_loan_needs_screen/how_many_days_loan_needs_view.dart';

class LoanPaymentDurationView extends StatelessWidget {
  const LoanPaymentDurationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<LoanPaymentDurationViewController>(
        LoanPaymentDurationViewController());
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
                      "Loan Payment",
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
                    "How would you prefer to repay the loan amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black30,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(30),
                  AppButton(
                    "Installment",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Security",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Full payment",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Less 1 month",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Less 6 month",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(15),
                  AppButton(
                    "Greater than 10 years",
                    buttonTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Get.to(const HowManyDaysLoanNeedsView());
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    },
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream:
                        LoanPaymentDurationViewController.to.isAdLoaded.stream,
                    builder: (context, snapshot) {
                      return LoanPaymentDurationViewController.to.bannerAd == null
                          ? const SizedBox()
                          : SafeArea(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: double.maxFinite,
                                height: LoanPaymentDurationViewController
                                    .to.bannerAd!.size.height
                                    .toDouble(),
                                child: AdWidget(
                                  ad: LoanPaymentDurationViewController
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
