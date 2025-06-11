import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/home/states/home_cubit.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/card.dart';
import 'package:poltry_farm/widgets/forms/form_control.dart';

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
      create: (context) => _homeCubit
        ..fetchCategories
        ..fetchRecommandations,
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
          resizeToAvoidBottomInset: false,
          appBar: PfAppBar(
            automaticallyImplyLeading: false,
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
                child: PfText(
                  text: 'Today\'s Rate',
                  variant: PfTextStyleVariant.bodyLarge,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              PfElevatedButton(
                height: 30,
                width: 78,
                semanticsLabel: 'Sell',
                child: PfText(
                  text: 'Sell',
                  variant: PfTextStyleVariant.labelLarge,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PfSettingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 95,
                    child: PfFormControls.searchTextBloc<HomeCubit, HomeState>(
                      selector: (state) => state.searchForm,
                      onChanged: (value) => _homeCubit.searchFormChanged(value),
                    ),
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: _homeCubit,
                    buildWhen: (p, c) =>
                        p.popularCategories != c.popularCategories ||
                        p.status != c.status,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PfText(
                            text: 'Popular Category',
                            variant: PfTextStyleVariant.labelSmall,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            height: 110,
                            child: RefreshIndicator.adaptive(
                              onRefresh: () async {
                                await _homeCubit.fetchCategories();
                              },
                              child: InfiniteListView.separated(
                                scrollDirection: Axis.horizontal,
                                delegate: PaginationDelegate(
                                  isLoading: state.status == HomeStatus.loading,
                                  hasError: state.status == HomeStatus.failure,
                                  itemCount:
                                      state.popularCategories?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final category =
                                        state.popularCategories?[index];
                                    return Column(
                                      children: [
                                        Container(
                                          width: 78,
                                          height: 78,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: context.colorScheme.primary,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  context.colorScheme.outline,
                                            ),
                                            child: PfCachedNetworkImage(
                                              width: 53,
                                              height: 57,
                                              url: category?.imageUrl ?? '',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        PfText(
                                          text: state.popularCategories?[index]
                                                  .name ??
                                              '',
                                          variant: PfTextStyleVariant.bodyLarge,
                                          fontWeight: FontWeight.bold,
                                        )
                                      ],
                                    );
                                  },
                                  onFetchData: () async {
                                    await _homeCubit.fetchCategories();
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: _homeCubit,
                    buildWhen: (p, c) =>
                        p.products != c.products || p.status != c.status,
                    builder: (context, state) {
                      return Expanded(
                        child: CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(
                              child: PfText(
                                text: 'Recommendations',
                                variant: PfTextStyleVariant.labelSmall,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 14),
                            ),
                            SliverFillRemaining(
                              child: RefreshIndicator.adaptive(
                                onRefresh: () async {
                                  await _homeCubit.fetchRecommandations();
                                },
                                child: InfiniteGridView(
                                  delegate: PaginationDelegate(
                                    isLoading:
                                        state.status == HomeStatus.loading,
                                    hasError:
                                        state.status == HomeStatus.failure,
                                    itemCount: state.products?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final category = state.products?[index];
                                      return PfCard(
                                        title: category?.name,
                                        subTitle: category?.quantity.toString(),
                                        description: category?.location,
                                        trailingIcon: Icon(
                                          Icons.phone,
                                          color: context.colorScheme.onSurface,
                                        ),
                                        image: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                          width: double.infinity,
                                          child: PfAssets.imgChickenFarm(
                                            height: 81,
                                            boxfit: BoxFit.cover,
                                          ),
                                        ),
                                        onTap: () {},
                                      );
                                    },
                                    onFetchData: () async {
                                      await _homeCubit.fetchRecommandations();
                                    },
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
