import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';
import 'package:poltry_farm/widgets/card.dart';
import 'package:poltry_farm/widgets/grid_view.dart';

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
          SizedBox(
            height: 250,
            child: PfLazyLoadGridView<int>(
              pageSize: 5,
              fetchPage: (page) {
                return Future.delayed(
                  const Duration(seconds: 1),
                  () => List.generate(5, (index) => index + (page - 1) * 5),
                );
              },
              itemBuilder: (context, item) => Card(
                child: Center(child: Text("$item")),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: PfLazyLoadGridView<int>(
              crossAxisCount: 1,
              pageSize: 5,
              fetchPage: (page) {
                return Future.delayed(
                  const Duration(seconds: 1),
                  () => List.generate(5, (index) => index + (page - 1) * 5),
                );
              },
              itemBuilder: (context, item) => PfCard(
                title: "Item $item",
                subTitle: "Subtitle $item",
                image: const Icon(Icons.image, size: 50),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Tapped on Item $item")),
                  );
                },
                semanticLabel: "Item $item, Subtitle $item",
              ),
              scrollDirection: Axis.horizontal,
            ),
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
