import 'package:emicalculator/styles/colors.dart';
import 'package:emicalculator/ui/screens/startup/startup_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../services/app_open_ad_manager_service.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/save_money.svg",
              height: 210,
              width: 210,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.orange,
              ),
            ).paddingOnly(bottom: 50),
          ),
          StreamBuilder(
            stream: AppOpenAdManagerService.to.isAdAvailable.stream,
            builder: (context, snapshot) {
              if (AppOpenAdManagerService.to.isAdAvailable.value) {
                StartupViewController.to.navigateAndShowAd();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
