import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/home/states/home_cubit.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/card.dart';
import 'package:poltry_farm/widgets/form_input.dart';

import 'package:poltry_farm/widgets/text.dart';
import 'package:poltry_farm/widgets/text_field.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PfHomeScreen extends StatefulWidget {
  const PfHomeScreen({super.key});

  @override
  State<PfHomeScreen> createState() => _PfHomeScreenState();
}

class _PfHomeScreenState extends State<PfHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..fetchCategories
        ..fetchRecommandations,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? S.current.errorFailedToLoadData),
              ),
            );
          }
          if (state.status == HomeStatus.success) {
            // hide snackbar if data is loaded successfully
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.onPrimary,
          appBar: PfAppBar(
            automaticallyImplyLeading: false,
            title: S.current.homePageTitle,
            actions: [
              PfElevatedButton(
                height: 30,
                width: 48,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                semanticsLabel: S.current.homePageAppBarSubActionButton,
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
                  text: S.current.homePageAppBarSubActionButton,
                  variant: PfTextStyleVariant.bodyLarge,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              PfElevatedButton(
                height: 30,
                width: 78,
                semanticsLabel: S.current.homePageAppBarActionButton,
                child: PfText(
                  text: S.current.homePageAppBarActionButton,
                  variant: PfTextStyleVariant.labelLarge,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
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
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _SearchInput(FocusNode()),
                const SizedBox(
                  height: 16,
                ),
                const _PopularCategories(),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, c) =>
                      p.products != c.products || p.status != c.status,
                  builder: (context, state) {
                    return Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: PfText(
                              text: S.current.homePageBodyTitle,
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
                                await context
                                    .read<HomeCubit>()
                                    .fetchRecommandations();
                              },
                              child: InfiniteGridView(
                                delegate: PaginationDelegate(
                                  loadMoreLoadingBuilder: (context) {
                                    return Shimmer(
                                      child: const PfCard(),
                                    );
                                  },
                                  firstPageLoadingBuilder: (context) {
                                    return SizedBox(
                                      height: 200,
                                      child: GridView.builder(
                                        itemCount: 6,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            Shimmer(
                                          child: const PfCard(),
                                        ),
                                      ),
                                    );
                                  },
                                  isLoading: state.status == HomeStatus.loading,
                                  hasError: state.status == HomeStatus.failure,
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
                                        child: PfCachedNetworkImage(
                                          semanticLabel: category?.name ?? '',
                                          height: 85,
                                          url: category?.imageUrl ?? '',
                                          boxFit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      onTap: () {},
                                    );
                                  },
                                  onFetchData: () async {
                                    await context
                                        .read<HomeCubit>()
                                        .fetchRecommandations();
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
    );
  }
}

class _PopularCategories extends StatelessWidget {
  const _PopularCategories();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (p, c) =>
          p.popularCategories != c.popularCategories || p.status != c.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PfText(
              text: S.current.homePageBodySubTitle,
              variant: PfTextStyleVariant.labelSmall,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 14,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 120),
              child: RefreshIndicator.adaptive(
                onRefresh: () async {
                  await context.read<HomeCubit>().fetchCategories();
                },
                child: InfiniteListView.separated(
                  scrollDirection: Axis.horizontal,
                  delegate: PaginationDelegate(
                    loadMoreLoadingBuilder: (context) => Shimmer(
                      child: const PfCard(),
                    ),
                    firstPageLoadingBuilder: (context) => ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Shimmer(
                            color: Colors.red,
                            child: const PfCard(),
                          );
                        }),
                    isLoading: state.status == HomeStatus.loading,
                    hasError: state.status == HomeStatus.failure,
                    itemCount: state.popularCategories?.length ?? 0,
                    itemBuilder: (context, index) {
                      final category = state.popularCategories?[index];
                      return Column(
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: context.colorScheme.primary,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: context.colorScheme.outline,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: PfCachedNetworkImage(
                                    semanticLabel: category?.name ?? '',
                                    width: 53,
                                    height: 57,
                                    url: category?.imageUrl ?? '',
                                    boxFit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          PfText(
                            text: state.popularCategories?[index].name ?? '',
                            variant: PfTextStyleVariant.bodyLarge,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      );
                    },
                    onFetchData: () async {
                      await context.read<HomeCubit>().fetchCategories();
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, PfProducts>(
      selector: (state) => state.searchForm,
      builder: (context, farmCapacity) {
        return PfTextField(
          key: const Key('HomeForm_SearchInput_textField'),
          semanticsLabel: S.current.formSearchSemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) {},
          hintText: S.of(context).formSearchHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: farmCapacity.value,
          prefixIcon: const Icon(
            Icons.search,
          ),
        );
      },
    );
  }
}
