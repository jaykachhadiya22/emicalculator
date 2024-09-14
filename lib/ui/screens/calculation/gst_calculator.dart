import 'package:flutter/material.dart';

class GstCalculator extends StatefulWidget {
  @override
  _GstCalculatorState createState() => _GstCalculatorState();
}

class _GstCalculatorState extends State<GstCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _gstRateController = TextEditingController();

  double _gstAmount = 0.0;
  double _totalAmount = 0.0;

  // Function to calculate GST and total amount
  void _calculateGst() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double gstRate = double.tryParse(_gstRateController.text) ?? 0;

    // Calculate GST Amount
    _gstAmount = (principal * gstRate) / 100;

    // Calculate Total Amount
    _totalAmount = principal + _gstAmount;

    setState(() {}); // Refresh the UI with the new results
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GST Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateGst,
              child: Text('Calculate GST'),
            ),
            SizedBox(height: 16),
            Text(
              'GST Amount: \$$_gstAmount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Amount: \$$_totalAmount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
