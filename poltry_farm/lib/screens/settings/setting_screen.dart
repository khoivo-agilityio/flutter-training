import 'package:flutter/material.dart';

class PfSettingScreen extends StatelessWidget {
  const PfSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Home Screen'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to User Infomation'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to View Ads'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Back to Home'),
        ),
      ],
    );
  }
}
