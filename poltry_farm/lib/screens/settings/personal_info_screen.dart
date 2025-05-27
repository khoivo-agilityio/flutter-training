import 'package:flutter/material.dart';

class PfPersonalInfoScreen extends StatelessWidget {
  const PfPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Setting Personal Info Screen'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Back to Setting'),
        ),
      ],
    );
  }
}
