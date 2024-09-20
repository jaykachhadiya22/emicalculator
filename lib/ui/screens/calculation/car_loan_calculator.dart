import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart';

class CarLoanComparison extends StatefulWidget {
  const CarLoanComparison({super.key});

  @override
  _CarLoanComparisonState createState() => _CarLoanComparisonState();
}

class _CarLoanComparisonState extends State<CarLoanComparison> {
  final TextEditingController _carPriceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _totalLoanCost = 0.0;
  double _emiResult = 0.0;
  double _difference = 0.0;

  void _calculateLoanVsFullPayment() {
    double carPrice = double.tryParse(_carPriceController.text) ?? 0;
    double annualRate = double.tryParse(_rateController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    double monthlyRate = annualRate / 12 / 100;

    int totalMonths = years * 12;

    if (monthlyRate > 0) {
      _emiResult =
          (carPrice * monthlyRate * pow(1 + monthlyRate, totalMonths)) /
              (pow(1 + monthlyRate, totalMonths) - 1);
    } else {
      _emiResult = carPrice / totalMonths;
    }

    _totalLoanCost = _emiResult * totalMonths;

    _difference = _totalLoanCost - carPrice;

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
          'Car Loan vs Full Payment Calculator',
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
              const Gap(70),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: _carPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Car Price (Full Payment)',
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
                    labelText: 'Loan Duration (Years)',
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
                onPressed: _calculateLoanVsFullPayment,
              ),
              const SizedBox(height: 16),
              Text(
                'Total Loan Cost: ${_totalLoanCost.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Difference (Loan vs Full Payment): ${_difference.toStringAsFixed(2)}',
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
