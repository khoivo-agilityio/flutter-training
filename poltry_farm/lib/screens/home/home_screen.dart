import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';

class PfHomeScreen extends StatelessWidget {
  const PfHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is Home Screen'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PfHomeSellScreen(),
                ),
              );
            },
            child: const Text('Navigate to Sell'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PfHomeTodayRateScreen(),
                ),
              );
            },
            child: const Text('Navigate to Today Rate'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PfSettingScreen(),
                ),
              );
            },
            child: const Text('Navigate to Farm Setting'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(PfPaths.login.name);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
