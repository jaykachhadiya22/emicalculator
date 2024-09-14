import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import '../select_calculator_screen/select_calculator_view.dart';

class HowManyDaysLoanNeedsView extends StatelessWidget {
  const HowManyDaysLoanNeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: SafeArea(
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
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
              const Gap(15),
              AppButton(
                "6 Month",
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
              const Gap(15),
              AppButton(
                "1 Year",
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
              const Gap(15),
              AppButton(
                "3 Years",
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
              const Gap(15),
              AppButton(
                "10 Years",
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
              const Gap(15),
              AppButton(
                "Greater than 20 years",
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: () => Get.to(const SelectCalculatorView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
