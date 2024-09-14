import 'package:flutter/material.dart';

class CashCounter extends StatefulWidget {
  @override
  _CashCounterState createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  final TextEditingController _oneDollarController = TextEditingController();
  final TextEditingController _fiveDollarController = TextEditingController();
  final TextEditingController _tenDollarController = TextEditingController();
  final TextEditingController _twentyDollarController = TextEditingController();
  final TextEditingController _fiftyDollarController = TextEditingController();
  final TextEditingController _hundredDollarController = TextEditingController();

  double _totalAmount = 0.0;

  // Function to calculate total cash
  void _calculateTotal() {
    double oneDollar = double.tryParse(_oneDollarController.text) ?? 0;
    double fiveDollar = double.tryParse(_fiveDollarController.text) ?? 0;
    double tenDollar = double.tryParse(_tenDollarController.text) ?? 0;
    double twentyDollar = double.tryParse(_twentyDollarController.text) ?? 0;
    double fiftyDollar = double.tryParse(_fiftyDollarController.text) ?? 0;
    double hundredDollar = double.tryParse(_hundredDollarController.text) ?? 0;

    // Calculate total amount
    _totalAmount = (oneDollar * 1) +
        (fiveDollar * 5) +
        (tenDollar * 10) +
        (twentyDollar * 20) +
        (fiftyDollar * 50) +
        (hundredDollar * 100);

    setState(() {}); // Refresh the UI with the new result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_oneDollarController, '1 Dollar'),
            _buildTextField(_fiveDollarController, '5 Dollars'),
            _buildTextField(_tenDollarController, '10 Dollars'),
            _buildTextField(_twentyDollarController, '20 Dollars'),
            _buildTextField(_fiftyDollarController, '50 Dollars'),
            _buildTextField(_hundredDollarController, '100 Dollars'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateTotal,
              child: Text('Calculate Total'),
            ),
            SizedBox(height: 16),
            Text(
              'Total Amount: \$$_totalAmount',
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
