import 'package:flutter/material.dart';

class PfMyAdsScreen extends StatelessWidget {
  const PfMyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is Setting My Ads Screen'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Back to Setting'),
        ),
      ],
    );
  }
}
