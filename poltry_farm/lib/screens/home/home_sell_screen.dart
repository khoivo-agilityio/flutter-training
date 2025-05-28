import 'package:flutter/material.dart';
import 'package:poltry_farm/screens/settings/view_ad_screen.dart';

class PfHomeSellScreen extends StatelessWidget {
  const PfHomeSellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is Home - Sell Screen'),
          ElevatedButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: const Text('Navigate Back to Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PfMyAdsScreen(),
                ),
              );
            },
            child: const Text('Navigate to View Ad'),
          ),
        ],
      ),
    );
  }
}
