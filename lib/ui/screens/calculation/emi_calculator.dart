import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({super.key});

  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  final _principalController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _tenureController = TextEditingController();
  String _emiResult = '';

  void _calculateEMI() {
    final principal = double.tryParse(_principalController.text) ?? 0;
    final annualInterestRate =
        double.tryParse(_interestRateController.text) ?? 0;
    final tenure = int.tryParse(_tenureController.text) ?? 0;

    final monthlyInterestRate = annualInterestRate / 12 / 100;
    final numberOfPayments = tenure;

    if (principal <= 0 || monthlyInterestRate <= 0 || numberOfPayments <= 0) {
      setState(() {
        _emiResult = 'Please enter valid values.';
      });
      return;
    }

    final emi = (principal *
            monthlyInterestRate *
            pow(1 + monthlyInterestRate, numberOfPayments)) /
        (pow(1 + monthlyInterestRate, numberOfPayments) - 1);

    setState(() {
      _emiResult = 'Your EMI is: ${emi.toStringAsFixed(2)}';
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
          'EMI Calculator',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _principalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Principal Amount',
                  fillColor: AppColors.white,
                  filled: true,
                  border: InputBorder.none,
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _interestRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Annual Interest Rate (%)',
                  fillColor: AppColors.white,
                  filled: true,
                  border: InputBorder.none,
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _tenureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tenure (Months)',
                  fillColor: AppColors.white,
                  filled: true,
                  border: InputBorder.none,
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              "Calculate",
              width: 150,
              buttonTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              onPressed: _calculateEMI,
            ),
            const SizedBox(height: 20),
            Text(
              _emiResult,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
