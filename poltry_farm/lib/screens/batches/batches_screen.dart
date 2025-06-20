import 'package:flutter/material.dart';
import 'package:poltry_farm/widgets/app_bar.dart';

class PfBatchesScreen extends StatelessWidget {
  const PfBatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: PfAppBar(
        title: 'Batches',
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('This is Batches Screen'),
        ],
      ),
    );
  }
}
