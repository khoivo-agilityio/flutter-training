import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/themes/typography.dart';
import 'package:poltry_farm/widgets/assets.dart';

class PfScaffoldWithBottomNav extends StatelessWidget {
  final Widget body;

  const PfScaffoldWithBottomNav({
    required this.body,
    super.key,
  });

  static final List<_NavItem> _navItems = [
    _NavItem(
      label: 'Buy/Sell',
      iconBuilder: (color) => PfAssets.icBuySell(color: color),
      route: PfPaths.home.path,
    ),
    _NavItem(
      label: 'Batches',
      iconBuilder: (color) => PfAssets.icBatches(color: color),
      route: PfPaths.batches.path,
    ),
    _NavItem(
      label: 'Feed Management',
      iconBuilder: (color) => Icon(
        Icons.trolley,
        color: color,
      ),
      route: PfPaths.feedManagement.path,
    ),
    _NavItem(
      label: 'Setting',
      iconBuilder: (color) => Icon(
        Icons.settings,
        color: color,
      ),
      route: PfPaths.setting.path,
    ),
  ];

  int _locationToTabIndex(String location) {
    final index =
        _navItems.indexWhere((item) => location.startsWith(item.route));
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final int currentIndex = _locationToTabIndex(location);

    return Scaffold(
      body: body,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: context.colorScheme.outline),
          BottomNavigationBar(
            selectedLabelStyle: TextStyle(
              fontFamily: PfTypography.familyBahnschrift,
              fontSize: PfTypography.fontSizeBodySmall,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.onSurfaceVariant,
              overflow: TextOverflow.ellipsis,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: PfTypography.familyBahnschrift,
              fontSize: PfTypography.fontSizeBodySmall,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.onSurfaceVariant,
              overflow: TextOverflow.ellipsis,
            ),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor: context.colorScheme.onPrimary,
            selectedItemColor: context.colorScheme.primary,
            unselectedItemColor: context.colorScheme.onSurface,
            currentIndex: currentIndex,
            onTap: (index) => context.go(_navItems[index].route),
            items: _navItems.mapIndexed((index, item) {
              final bool isSelected = index == currentIndex;
              final Color iconColor = isSelected
                  ? context.colorScheme.onSurfaceVariant
                  : context.colorScheme.onSurface;
              final Color backgroundColor = isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.surfaceContainer;
              return BottomNavigationBarItem(
                backgroundColor: context.colorScheme.onPrimary,
                icon: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  child: item.iconBuilder(iconColor),
                ),
                label: item.label,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final Widget Function(Color color) iconBuilder;
  final String route;

  const _NavItem({
    required this.label,
    required this.iconBuilder,
    required this.route,
  });
}
