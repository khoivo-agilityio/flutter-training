import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/button.dart';

import 'package:poltry_farm/widgets/grid_view.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfHomeScreen extends StatelessWidget {
  const PfHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PfAppBar(
        title: 'Happy Poultry Farm',
        actions: [
          PfElevatedButton(
              height: 30,
              width: 78,
              semanticsLabel: 'Sell',
              child: PfText(
                text: 'Sell',
                variant: PfTextStyleVariant.labelLarge,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: PfText(
                  text: 'Popular Category',
                  variant: PfTextStyleVariant.labelSmall,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                color: Colors.transparent,
                height: 105,
                child: PfLazyLoadGridView<int>(
                  childAspectRatio: 1,
                  padding: 0,
                  spacing: 0,
                  crossAxisCount: 1,
                  pageSize: 5,
                  fetchPage: (page) {
                    return Future.delayed(
                      const Duration(seconds: 1),
                      () => List.generate(5, (index) => index + (page - 1) * 5),
                    );
                  },
                  itemBuilder: (context, item) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.outline,
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                        child: PfAssets.imgChickenFarm(
                          width: 78,
                          height: 78,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const PfText(
                        text: 'Chickens',
                        variant: PfTextStyleVariant.bodyLarge,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
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
