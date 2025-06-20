import 'package:flutter/material.dart';
import 'package:poltry_farm/widgets/app_bar.dart';

class PfFeedManagementScreen extends StatelessWidget {
  const PfFeedManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: PfAppBar(
        title: 'Feed Management',
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is Feed Management Screen'),
        ],
      ),
    );
  }
}
