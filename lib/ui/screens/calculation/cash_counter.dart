import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../styles/colors.dart';
import '../../widgets/app.button.dart';
import 'formula_controller.dart';

class CashCounter extends StatefulWidget {
  const CashCounter({super.key});

  @override
  _CashCounterState createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  final TextEditingController _oneDollarController = TextEditingController();
  final TextEditingController _fiveDollarController = TextEditingController();
  final TextEditingController _tenDollarController = TextEditingController();
  final TextEditingController _twentyDollarController = TextEditingController();
  final TextEditingController _fiftyDollarController = TextEditingController();
  final TextEditingController _hundredDollarController =
      TextEditingController();

  double _totalAmount = 0.0;

  void _calculateTotal() {
    double oneDollar = double.tryParse(_oneDollarController.text) ?? 0;
    double fiveDollar = double.tryParse(_fiveDollarController.text) ?? 0;
    double tenDollar = double.tryParse(_tenDollarController.text) ?? 0;
    double twentyDollar = double.tryParse(_twentyDollarController.text) ?? 0;
    double fiftyDollar = double.tryParse(_fiftyDollarController.text) ?? 0;
    double hundredDollar = double.tryParse(_hundredDollarController.text) ?? 0;

    _totalAmount = (oneDollar * 1) +
        (fiveDollar * 5) +
        (tenDollar * 10) +
        (twentyDollar * 20) +
        (fiftyDollar * 50) +
        (hundredDollar * 100);

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
          'Cash Counter',
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
            children: [
              const Gap(20),
              _buildTextField(_oneDollarController, '1 Dollar'),
              _buildTextField(_fiveDollarController, '5 Dollars'),
              _buildTextField(_tenDollarController, '10 Dollars'),
              _buildTextField(_twentyDollarController, '20 Dollars'),
              _buildTextField(_fiftyDollarController, '50 Dollars'),
              _buildTextField(_hundredDollarController, '100 Dollars'),
              const SizedBox(height: 16),
              AppButton(
                "Calculate",
                width: 150,
                buttonTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                onPressed: _calculateTotal,
              ),
              const SizedBox(height: 16),
              Text(
                'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
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
    ).paddingOnly(bottom: 16);
  }
}
