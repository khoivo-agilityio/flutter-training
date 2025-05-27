import 'package:flutter/material.dart';

class PfHomeSellScreen extends StatelessWidget {
  const PfHomeSellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Home - Sell Screen'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate Back to Home'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to View Ad'),
        ),
      ],
    );
  }
}
