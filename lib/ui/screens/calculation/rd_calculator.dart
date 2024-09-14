import 'package:flutter/material.dart';
import 'dart:math'; // Importing the math library for the pow function

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
    double annualInterestRate = double.tryParse(_interestRateController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;

    // Convert annual interest rate from percentage to decimal
    double rate = annualInterestRate / 100;

    // Number of times interest is compounded per year (monthly)
    int n = 12;

    // Calculate maturity amount using RD formula
    double maturityAmount = principal * ((pow(1 + (rate / n), n * time) - 1) / (rate / n)) * (1 + (rate / n));

    setState(() {
      _maturityAmount = maturityAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RD Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_principalController, 'Monthly Deposit Amount'),
            SizedBox(height: 16),
            _buildTextField(_interestRateController, 'Annual Interest Rate (%)'),
            SizedBox(height: 16),
            _buildTextField(_timeController, 'Time Period (Years)'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateRd,
              child: Text('Calculate Maturity Amount'),
            ),
            SizedBox(height: 16),
            Text(
              'Maturity Amount: \$${_maturityAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
