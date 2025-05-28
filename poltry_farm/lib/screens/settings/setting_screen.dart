import 'package:flutter/material.dart';
import 'package:poltry_farm/screens/settings/personal_info_screen.dart';
import 'package:poltry_farm/screens/settings/view_ad_screen.dart';

class PfSettingScreen extends StatelessWidget {
  const PfSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is Setting Screen'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PfPersonalInfoScreen(),
                ),
              );
            },
            child: const Text('Navigate to User Infomation'),
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
            child: const Text('Navigate to View Ads'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
