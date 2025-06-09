import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/home/states/home_cubit.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';
import 'package:poltry_farm/shared/category_models.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/button.dart';

import 'package:poltry_farm/widgets/grid_view.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfHomeScreen extends StatefulWidget {
  const PfHomeScreen({super.key});

  @override
  State<PfHomeScreen> createState() => _PfHomeScreenState();
}

class _PfHomeScreenState extends State<PfHomeScreen> {
  late final HomeCubit _homeCubit;
  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit..fetchCategories,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to load data'),
              ),
            );
          }
          if (state.status == HomeStatus.success) {
            // hide snackbar if data is loaded successfully
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: Scaffold(
          appBar: PfAppBar(
            title: 'Happy Poultry Farm',
            actions: [
              PfElevatedButton(
                height: 30,
                width: 78,
                semanticsLabel: 'Today\'s Rate',
                fillColor: context.colorScheme.onPrimary,
                textColor: context.colorScheme.primary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PfHomeTodayRateScreen(),
                    ),
                  );
                },
                child: const PfText(
                  text: 'Today\'s Rate',
                  variant: PfTextStyleVariant.labelLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              PfElevatedButton(
                height: 30,
                width: 78,
                semanticsLabel: 'Sell',
                child: const PfText(
                  text: 'Sell',
                  variant: PfTextStyleVariant.labelLarge,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PfHomeSellScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: PfText(
                      text: 'Popular Category',
                      variant: PfTextStyleVariant.labelSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: _homeCubit,
                    buildWhen: (p, c) =>
                        p.popularCategories != c.popularCategories ||
                        p.status != c.status,
                    builder: (context, state) {
                      return Container(
                        color: Colors.transparent,
                        height: 105,
                        child: PfLazyLoadGridView<PfCategoryModel>(
                          childAspectRatio: 1,
                          padding: 0,
                          spacing: 0,
                          crossAxisCount: 1,
                          fetchPage: (page) => _homeCubit.fetchCategories(page),
                          itemBuilder: (context, item) => Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.outline,
                                    borderRadius:
                                        BorderRadiusGeometry.circular(15),
                                  ),
                                  child: PfCachedNetworkImage(
                                    url: item.imageUrl ?? '',
                                    width: 78,
                                    height: 78,
                                  )),
                              const SizedBox(
                                height: 9,
                              ),
                              PfText(
                                text: item.name,
                                variant: PfTextStyleVariant.bodyLarge,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    },
                  ),
                ],
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
        ),
      ),
    );
  }
}
