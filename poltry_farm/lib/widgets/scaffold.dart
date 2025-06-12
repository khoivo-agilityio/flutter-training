import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/router.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;
  const ScaffoldWithBottomNav({required this.child, super.key});

  static final List<_NavItem> _navItems = [
    _NavItem(label: 'Home', icon: Icons.home, route: PfPaths.home.path),
    _NavItem(
        label: 'Setting', icon: Icons.settings, route: PfPaths.setting.path),
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
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(
            height: 1,
            color: context.colorScheme.outline,
          ),
          BottomNavigationBar(
            backgroundColor: context.colorScheme.onPrimary,
            currentIndex: currentIndex,
            onTap: (index) {
              context.go(_navItems[index].route);
            },
            items: _navItems
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.label,
                    ))
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

  const _NavItem(
      {required this.label, required this.icon, required this.route});
}
