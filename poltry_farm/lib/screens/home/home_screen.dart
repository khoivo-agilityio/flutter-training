import 'package:flutter/material.dart';

class PfLoginScreen extends StatelessWidget {
  const PfLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Home Screen'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to Sell'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to Today Rate'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to Farm Setting'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
