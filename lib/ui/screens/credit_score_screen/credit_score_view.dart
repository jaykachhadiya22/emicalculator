import 'package:emicalculator/ui/screens/loan_payment_duration_screen/loan_payment_duration_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'credit_score_view_controller.dart';

class CreditScoreView extends StatefulWidget {
  const CreditScoreView({super.key});

  @override
  _CreditScoreViewState createState() => _CreditScoreViewState();
}

class _CreditScoreViewState extends State<CreditScoreView>
    with TickerProviderStateMixin {
  final List<bool> _isStarted = [false, false, false, false, false];
  final List<bool> _isCompleted = [false, false, false, false, false];
  final int _delay = 500;
  final int _completedProgressDelay = 600;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      5,
      (index) => AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this),
    );

    _animations = _controllers
        .map(
          (controller) => Tween<double>(begin: 0, end: 100).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    _startAnimations();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _startAnimations() async {
    for (int i = 0; i < _isStarted.length; i++) {
      await Future.delayed(Duration(milliseconds: _delay));
      if (mounted) {
        setState(() {
          _isStarted[i] = true;
        });
        _controllers[i].forward();
      }

      await Future.delayed(Duration(milliseconds: _completedProgressDelay));
      if (mounted) {
        setState(() {
          _isCompleted[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put<CreditScoreViewController>(CreditScoreViewController());
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(40),
                const Text(
                  "Make sure someone is available",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(50),
                singleProgressWidget(
                  title: "Credit score",
                  isCompleted: _isCompleted[0],
                  progressAnimation: _animations[0],
                  isStarted: _isStarted[0],
                ),
                const Gap(20),
                singleProgressWidget(
                  title: "Salary slips",
                  isCompleted: _isCompleted[1],
                  progressAnimation: _animations[1],
                  isStarted: _isStarted[1],
                ),
                const Gap(20),
                singleProgressWidget(
                  title: "Profession",
                  isCompleted: _isCompleted[2],
                  progressAnimation: _animations[2],
                  isStarted: _isStarted[2],
                ),
                const Gap(20),
                singleProgressWidget(
                  title: "Salary",
                  isCompleted: _isCompleted[3],
                  isStarted: _isStarted[3],
                  progressAnimation: _animations[3],
                ),
                const Gap(20),
                singleProgressWidget(
                  title: "Bank Statements",
                  isCompleted: _isCompleted[4],
                  isStarted: _isStarted[4],
                  progressAnimation: _animations[4],
                ),
                const Gap(20),
                StreamBuilder(
                  stream: CreditScoreViewController.to.isAdLoaded.stream,
                  builder: (context, snapshot) {
                    return CreditScoreViewController.to.bannerAd == null
                        ? const SizedBox()
                        : SafeArea(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: double.maxFinite,
                              height: CreditScoreViewController
                                  .to.bannerAd!.size.height
                                  .toDouble(),
                              child: AdWidget(
                                ad: CreditScoreViewController.to.bannerAd!,
                              ),
                            ),
                          ).paddingOnly(top: 10);
                  },
                ),
                const Gap(20),
                AppButton(
                  "Next",
                  buttonTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  onPressed: () => Get.to(const LoanPaymentDurationView()),
                ),
                const Gap(15),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget singleProgressWidget({
  required String title,
  required bool isCompleted,
  required bool isStarted,
  required Animation<double> progressAnimation,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isStarted ? AppColors.white : AppColors.black50,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (isStarted)
            isCompleted
                ? SvgPicture.asset(
                    "assets/icons/tick.svg",
                    height: 12,
                    width: 12,
                    color: AppColors.yellow,
                  )
                : AnimatedBuilder(
                    animation: progressAnimation,
                    builder: (context, child) {
                      return Text(
                        "${progressAnimation.value.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
        ],
      ),
      const Gap(10),
      if (isStarted)
        AnimatedBuilder(
          animation: progressAnimation,
          builder: (context, child) {
            return LinearProgressIndicator(
              color: AppColors.yellow,
              backgroundColor: AppColors.black80,
              value: progressAnimation.value / 100,
              borderRadius: BorderRadius.circular(4),
              minHeight: 2,
            );
          },
        ),
    ],
  );
}
