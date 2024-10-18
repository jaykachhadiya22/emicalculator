import 'package:emicalculator/styles/colors.dart';
import 'package:emicalculator/ui/screens/on_bording_two_screen/on_boarding_two_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/pre_loade_industrial_ad_first_service.dart';
import '../../widgets/app.button.dart';
import 'on_boarding_first_view_controller.dart';

class OnBoardingFirstView extends StatelessWidget {
  const OnBoardingFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<OnBoardingFirstViewController>(
      OnBoardingFirstViewController(),
    );
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: Stack(
        children: [
          StreamBuilder(
            stream: OnBoardingFirstViewController.to.isAdLoaded.stream,
            builder: (context, snapshot) {
              return OnBoardingFirstViewController.to.bannerAd == null
                  ? const SizedBox()
                  : SafeArea(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: double.maxFinite,
                        height: OnBoardingFirstViewController
                            .to.bannerAd!.size.height
                            .toDouble(),
                        child: AdWidget(
                          ad: OnBoardingFirstViewController.to.bannerAd!,
                        ),
                      ),
                    ).paddingOnly(top: 10);
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/vecteezy_calculator-budget-icon_50737541.png",
              height: 210,
              width: 210,
            ),
          ).paddingOnly(top: 120),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Loan\nEMI Calculator",
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
                const Gap(10),
                const Text(
                  "Get a clear view of your\nloan payments.",
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
                    if (!OnBoardingFirstViewController.to.isOnlyShowApp.value) {
                      PreLoadIndustrialAdFirstService.to.showInterstitialAd();
                    }
                    Get.to(const OnBoardingTwoView());
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
