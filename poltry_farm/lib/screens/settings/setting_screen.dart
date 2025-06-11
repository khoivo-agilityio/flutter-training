import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/screens/settings/personal_info_screen.dart';
import 'package:poltry_farm/screens/settings/view_ad_screen.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfSettingScreen extends StatelessWidget {
  const PfSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PfAppBar(
        title: 'Farm Settings',
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Divider(
              height: 1,
              color: context.colorScheme.outline,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              title: const PfText(
                text: 'User Information',
                variant: PfTextStyleVariant.labelLarge,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PfPersonalInfoScreen(),
                  ),
                );
              },
            ),
            Divider(
              height: 1,
              color: context.colorScheme.outline,
            ),
            ListTile(
              leading: const Icon(Icons.ads_click),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              title: const PfText(
                text: 'My Ads',
                variant: PfTextStyleVariant.labelLarge,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PfMyAdsScreen(),
                  ),
                );
              },
            ),
            Divider(
              height: 1,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
