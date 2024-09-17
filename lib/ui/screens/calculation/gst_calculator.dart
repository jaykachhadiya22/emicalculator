import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart';

class GstCalculator extends StatefulWidget {
  const GstCalculator({super.key});

  @override
  _GstCalculatorState createState() => _GstCalculatorState();
}

class _GstCalculatorState extends State<GstCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _gstRateController = TextEditingController();

  double _gstAmount = 0.0;
  double _totalAmount = 0.0;

  void _calculateGst() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double gstRate = double.tryParse(_gstRateController.text) ?? 0;

    _gstAmount = (principal * gstRate) / 100;

    _totalAmount = principal + _gstAmount;

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
          'GST Calculator',
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
              const Gap(100),
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
                  controller: _gstRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'GST Rate (%)',
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
                onPressed: _calculateGst,
              ),
              const SizedBox(height: 16),
              Text(
                'GST Amount: \$${_gstAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
              Text(
                'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
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
