import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart';

class CreditCardPaymentCalculator extends StatefulWidget {
  const CreditCardPaymentCalculator({super.key});

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

  void _calculateRewardsAndPenalties() {
    double spending = double.tryParse(_spendingController.text) ?? 0;
    double rewardRate = double.tryParse(_rewardRateController.text) ?? 0;
    double penaltyRate = double.tryParse(_penaltyRateController.text) ?? 0;
    double outstandingBalance =
        double.tryParse(_outstandingBalanceController.text) ?? 0;

    _totalRewards = (spending * rewardRate) / 100;

    _totalPenalty = (outstandingBalance * penaltyRate) / 100;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {});
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
          'Credit Card Payment Calculator',
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
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Total Monthly Penalty: ${_totalPenalty.toStringAsFixed(2)}',
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
