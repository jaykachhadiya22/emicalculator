import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart';

class FixedDepositCalculator extends StatefulWidget {
  const FixedDepositCalculator({super.key});

  @override
  _FixedDepositCalculatorState createState() => _FixedDepositCalculatorState();
}

class _FixedDepositCalculatorState extends State<FixedDepositCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _totalAmount = 0.0;
  double _interestAmount = 0.0;

  void _calculateFixedDeposit() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    _totalAmount = principal * pow((1 + rate / 100), years);
    _interestAmount = _totalAmount - principal;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        leading: GestureDetector(
          onTap: Get.back,
          child: SvgPicture.asset(
            "assets/icons/left_arrow.svg",
            height: 25,
            width: 25,
          ).paddingOnly(left: 15),
        ),
        leadingWidth: 40,
        title: const Text(
          'Fixed Deposit Calculator',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(60),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: _principalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Principal Amount',
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: _rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Annual Interest Rate (%)',
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: _yearsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time Period (Years)',
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                "Calculate",
                width: 150,
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: _calculateFixedDeposit,
              ),
              const SizedBox(height: 16),
              Text(
                'Principal Amount: ${_principalController.text}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Total Amount After Maturity: ${_totalAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Total Interest Earned: ${_interestAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const Gap(20),
              StreamBuilder(
                stream: FormulaController.to.isAdLoaded.stream,
                builder: (context, snapshot) {
                  return FormulaController.to.bannerAd == null
                      ? const SizedBox()
                      : SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: double.maxFinite,
                        height: FormulaController.to.bannerAd!.size.height
                            .toDouble(),
                        child: AdWidget(
                          ad: FormulaController.to.bannerAd!,
                        ),
                      ),
                    ),
                  ).paddingOnly(top: 10);
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
