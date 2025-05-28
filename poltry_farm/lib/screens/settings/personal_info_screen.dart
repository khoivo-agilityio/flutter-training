import 'package:flutter/material.dart';

class PfPersonalInfoScreen extends StatelessWidget {
  const PfPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is Setting Personal Info Screen'),
          ElevatedButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: const Text('Back to Setting'),
          ),
        ],
      ),
    );
  }
}
