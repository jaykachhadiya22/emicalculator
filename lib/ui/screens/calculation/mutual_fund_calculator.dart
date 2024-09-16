import 'package:emicalculator/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:get/get_core/src/get_main.dart';

import '../../widgets/app.button.dart';

class MutualFundCalculator extends StatefulWidget {
  const MutualFundCalculator({super.key});

  @override
  _MutualFundCalculatorState createState() => _MutualFundCalculatorState();
}

class _MutualFundCalculatorState extends State<MutualFundCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _result = 0.0;

  void _calculateMutualFund() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    _result = principal * pow((1 + (rate / 100)), years);

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
          'Mutual Fund Calculator',
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
          children: [
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
                  labelText: 'Rate of Return (%)',
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
                  labelText: 'Investment Duration (Years)',
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
            const SizedBox(height: 20),
            AppButton(
              "Calculate",
              width: 150,
              buttonTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              onPressed: _calculateMutualFund,
            ),
            const SizedBox(height: 20),
            Text(
              'Future Value: ${_result.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
