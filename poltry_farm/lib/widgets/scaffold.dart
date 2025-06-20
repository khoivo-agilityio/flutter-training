import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/themes/app_palette.dart';
import 'package:poltry_farm/themes/typography.dart';

class PfScaffoldWithBottomNav extends StatelessWidget {
  final Widget body;

  const PfScaffoldWithBottomNav({
    required this.body,
    super.key,
  });

  static final List<_NavItem> _navItems = [
    _NavItem(
      label: 'Home',
      icon: Icons.home,
      route: PfPaths.home.path,
    ),
    _NavItem(
      label: 'Batches',
      icon: Icons.auto_graph_sharp,
      route: PfPaths.batches.path,
    ),
    _NavItem(
      label: 'Feed Management',
      icon: Icons.carpenter,
      route: PfPaths.feedManagement.path,
    ),
    _NavItem(
      label: 'Setting',
      icon: Icons.settings,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(
            height: 1,
            color: context.colorScheme.outline,
          ),
          BottomNavigationBar(
            selectedLabelStyle: const TextStyle(
              fontFamily: PfTypography.familyBahnschrift,
              fontSize: PfTypography.fontSizeBodySmall,
              fontWeight: FontWeight.w400,
              color: PfPalette.genericBlack,
              overflow: TextOverflow.ellipsis,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: PfTypography.familyBahnschrift,
              fontSize: PfTypography.fontSizeBodySmall,
              fontWeight: FontWeight.w400,
              color: PfPalette.genericBlack,
              overflow: TextOverflow.clip,
            ),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor: context.colorScheme.onPrimary,
            selectedItemColor: context.colorScheme.primary,
            unselectedItemColor: context.colorScheme.onSurface,
            currentIndex: currentIndex,
            onTap: (index) {
              context.go(_navItems[index].route);
            },
            items: _navItems
                .map(
                  (item) => BottomNavigationBarItem(
                    backgroundColor: context.colorScheme.onPrimary,
                    activeIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.primary,
                      ),
                      child: Icon(
                        item.icon,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    icon: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.surfaceContainer,
                      ),
                      child: Icon(
                        item.icon,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
