import 'package:flutter/material.dart';

class PfNotFoundScreen extends StatelessWidget {
  const PfNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is Not Found Screen'),
        ],
      ),
    );
  }
}
