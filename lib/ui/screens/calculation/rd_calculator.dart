import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart'; // Importing the math library for the pow function

class RdCalculator extends StatefulWidget {
  @override
  _RdCalculatorState createState() => _RdCalculatorState();
}

class _RdCalculatorState extends State<RdCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  double _maturityAmount = 0.0;

  void _calculateRd() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double annualInterestRate =
        double.tryParse(_interestRateController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;

    double rate = annualInterestRate / 100;

    int n = 12;

    double maturityAmount = principal *
        ((pow(1 + (rate / n), n * time) - 1) / (rate / n)) *
        (1 + (rate / n));

    setState(() {
      _maturityAmount = maturityAmount;
    });
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
          'RD Calculator',
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
              const Gap(50),
              _buildTextField(_principalController, 'Monthly Deposit Amount'),
              const SizedBox(height: 16),
              _buildTextField(
                  _interestRateController, 'Annual Interest Rate (%)'),
              const SizedBox(height: 16),
              _buildTextField(_timeController, 'Time Period (Years)'),
              const SizedBox(height: 16),
              AppButton(
                "Calculate",
                width: 150,
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: _calculateRd,
              ),
              const SizedBox(height: 16),
              Text(
                'Maturity Amount: \$${_maturityAmount.toStringAsFixed(2)}',
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

  // Helper method to create text fields
  Widget _buildTextField(TextEditingController controller, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
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
    );
  }
}
