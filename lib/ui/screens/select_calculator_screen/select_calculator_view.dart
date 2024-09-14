import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';

class SelectCalculatorView extends StatelessWidget {
  const SelectCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: AppColors.yellowGradient,
            ),
            child: Align(
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Text(
                    "EMI Calculator",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  Gap(3),
                  Text(
                    "Compound Interest Calculator",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ).paddingOnly(top: 40, bottom: 20),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(30),
                  singleListWidget(
                    onTap: () {},
                    title: 'EMI Calculator',
                    imagePath: "calculator.svg",
                    subTitle: "A tool to calculate loan EMI easily",
                  ),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'Mutual Fund Calculator',
                    imagePath: "mutual_fund_calculator.svg",
                    subTitle: "Calculate returns on mutual fund investments.",
                  ),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'Loan Interest Calculator',
                    subTitle: "Quickly find interest on your loan.",
                    imagePath: "loan_interest.svg",
                  ),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'Car Loan Calculator',
                    subTitle: "Estimate your car loan payments.",
                    imagePath: "car_loan.svg",
                  ),
                  const Gap(20),
                  singleListWidget(
                      onTap: () {},
                      title: 'Fixed Deposit Calculator',
                      subTitle: "Compute returns on fixed deposits.",
                      imagePath: "fix_deposit.svg"),
                  const Gap(20),
                  singleListWidget(
                      onTap: () {},
                      title: 'Credit Card Payment',
                      subTitle: "manage credit card payments.",
                      imagePath: "credit_card_payment.svg"),
                  const Gap(20),
                  singleListWidget(
                      onTap: () {},
                      title: 'Basic Interest Calculator',
                      subTitle: "Calculate simple interest quickly.",
                      imagePath: "basic_interest.svg"),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'GST Calculator',
                    subTitle: "Determine GST on your purchases easily.",
                    imagePath: "gst_calculator.svg",
                  ),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'Cash Counter',
                    subTitle: "Manage and count cash transactions.",
                    imagePath: "cash_counter.svg",
                  ),
                  const Gap(20),
                  singleListWidget(
                    onTap: () {},
                    title: 'RD Calculator',
                    subTitle: "Calculate recurring deposit returns.",
                    imagePath: "rd.svg",
                  ),
                  const Gap(30),
                ],
              ).paddingSymmetric(horizontal: 28),
            ),
          ),
        ],
      ),
    );
  }
}

Widget singleListWidget(
    {required VoidCallback onTap,
    required String title,
    String subTitle = "",
    String imagePath = "calculator.svg",
    double size = 34}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Gap(15),
          SvgPicture.asset(
            "assets/icons/$imagePath",
            width: size,
            height: size,
            color: Colors.black,
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.black70,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ).paddingOnly(top: 2),
                const Gap(1),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          SvgPicture.asset(
            "assets/icons/short_right_arrow.svg",
            width: 14,
            height: 14,
            color: Colors.black,
          ),
          const Gap(20),
        ],
      ).paddingSymmetric(vertical: 10),
    ),
  );
}
