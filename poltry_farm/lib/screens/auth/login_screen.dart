import 'package:flutter/material.dart';

class PfLoginScreen extends StatelessWidget {
  const PfLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Login Screen'),
        ElevatedButton(onPressed: () {}, child: const Text('Navigate to Home')),
      ],
    );
  }
}
