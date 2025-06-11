import 'package:flutter/material.dart';

import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/avartar.dart';

class PfMyAdsScreen extends StatelessWidget {
  const PfMyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<UserDbModel>('userBox');

    return Scaffold(
      appBar: const PfAppBar(
        title: 'User Infomation',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            _Avatar(hive),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar(this.hive);

  final Box<UserDbModel> hive;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BoxEvent>(
      stream: hive.watch(),
      builder: (context, snapshot) {
        final user = hive.get('userBox');

        return Hero(
          tag: 'avatar',
          child: Material(
            color: Colors.transparent,
            child: PfAvatar(imgUrl: user?.avatarUrl ?? '', size: 96),
          ),
        );
      },
    );
  }
}
