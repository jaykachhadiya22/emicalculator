import 'package:flutter/material.dart';

class CreditCardPaymentCalculator extends StatefulWidget {
  @override
  _CreditCardPaymentCalculatorState createState() => _CreditCardPaymentCalculatorState();
}

class _CreditCardPaymentCalculatorState extends State<CreditCardPaymentCalculator> {
  final TextEditingController _spendingController = TextEditingController();
  final TextEditingController _rewardRateController = TextEditingController();
  final TextEditingController _penaltyRateController = TextEditingController();
  final TextEditingController _outstandingBalanceController = TextEditingController();

  double _totalRewards = 0.0;
  double _totalPenalty = 0.0;

  // Function to calculate monthly rewards and penalties
  void _calculateRewardsAndPenalties() {
    double spending = double.tryParse(_spendingController.text) ?? 0;
    double rewardRate = double.tryParse(_rewardRateController.text) ?? 0;
    double penaltyRate = double.tryParse(_penaltyRateController.text) ?? 0;
    double outstandingBalance = double.tryParse(_outstandingBalanceController.text) ?? 0;

    // Calculate rewards
    _totalRewards = (spending * rewardRate) / 100;

    // Calculate penalties
    _totalPenalty = (outstandingBalance * penaltyRate) / 100;

    setState(() {}); // Refresh the UI with the new result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card Payment Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateRewardsAndPenalties,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            Text(
              'Total Monthly Rewards: $_totalRewards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Monthly Penalty: $_totalPenalty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
