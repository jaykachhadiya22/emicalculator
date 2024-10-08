import 'package:emicalculator/styles/colors.dart';
import 'package:emicalculator/ui/screens/startup/startup_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_open_ad_manager_service.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/play_store_512.png",
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
