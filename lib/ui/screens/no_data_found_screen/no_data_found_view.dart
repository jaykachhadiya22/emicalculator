import 'package:flutter/material.dart';

class NoDataFoundView extends StatelessWidget {
  const NoDataFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Under maintenance",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
