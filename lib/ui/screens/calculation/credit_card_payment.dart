import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';

class CreditCardPaymentCalculator extends StatefulWidget {
  @override
  _CreditCardPaymentCalculatorState createState() =>
      _CreditCardPaymentCalculatorState();
}

class _CreditCardPaymentCalculatorState
    extends State<CreditCardPaymentCalculator> {
  final TextEditingController _spendingController = TextEditingController();
  final TextEditingController _rewardRateController = TextEditingController();
  final TextEditingController _penaltyRateController = TextEditingController();
  final TextEditingController _outstandingBalanceController =
      TextEditingController();

  double _totalRewards = 0.0;
  double _totalPenalty = 0.0;

  // Function to calculate monthly rewards and penalties
  void _calculateRewardsAndPenalties() {
    double spending = double.tryParse(_spendingController.text) ?? 0;
    double rewardRate = double.tryParse(_rewardRateController.text) ?? 0;
    double penaltyRate = double.tryParse(_penaltyRateController.text) ?? 0;
    double outstandingBalance =
        double.tryParse(_outstandingBalanceController.text) ?? 0;

    // Calculate rewards
    _totalRewards = (spending * rewardRate) / 100;

    // Calculate penalties
    _totalPenalty = (outstandingBalance * penaltyRate) / 100;

    setState(() {}); // Refresh the UI with the new result
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
          'Credit Card Payment Calculator',
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _spendingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Monthly Spending',
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
                controller: _rewardRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reward Rate (%)',
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
                controller: _penaltyRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Penalty Rate (%)',
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
                controller: _outstandingBalanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Outstanding Balance',
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
              onPressed: _calculateRewardsAndPenalties,
            ),
            const SizedBox(height: 16),
            Text(
              'Total Monthly Rewards: ${_totalRewards.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            Text(
              'Total Monthly Penalty: ${_totalPenalty.toStringAsFixed(2)}',
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
}
