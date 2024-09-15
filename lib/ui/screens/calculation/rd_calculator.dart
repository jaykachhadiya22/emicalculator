import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart'; // Importing the math library for the pow function

class RdCalculator extends StatefulWidget {
  @override
  _RdCalculatorState createState() => _RdCalculatorState();
}

class _RdCalculatorState extends State<RdCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  double _maturityAmount = 0.0;

  // Function to calculate maturity amount
  void _calculateRd() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double annualInterestRate =
        double.tryParse(_interestRateController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;

    // Convert annual interest rate from percentage to decimal
    double rate = annualInterestRate / 100;

    // Number of times interest is compounded per year (monthly)
    int n = 12;

    // Calculate maturity amount using RD formula
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
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
