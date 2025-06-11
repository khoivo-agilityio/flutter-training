import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/screens/home/states/home_sell_cubit.dart';
import 'package:poltry_farm/screens/settings/view_ad_screen.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfHomeSellScreen extends StatefulWidget {
  const PfHomeSellScreen({super.key});

  @override
  State<PfHomeSellScreen> createState() => _PfHomeSellScreenState();
}

class _PfHomeSellScreenState extends State<PfHomeSellScreen> {
  late final HomeSellCubit _cubit;
  @override
  void initState() {
    _cubit = HomeSellCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit..fetchCategories(),
      child: Scaffold(
        appBar: const PfAppBar(title: 'What are you selling?'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HomeSellCubit, HomeSellState>(
              builder: (context, state) {
                return Expanded(
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          await _cubit.fetchCategories();
                        },
                        child: InfiniteGridView(
                          delegate: PaginationDelegate(
                            isLoading: state.status == HomeSellStatus.loading,
                            hasError: state.status == HomeSellStatus.failure,
                            itemCount: state.popularCategories?.length ?? 0,
                            itemBuilder: (context, index) {
                              final category = state.popularCategories?[index];
                              return Column(
                                children: [
                                  Container(
                                    width: 96,
                                    height: 96,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: context.colorScheme.primary,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: context.colorScheme.outline,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: PfCachedNetworkImage(
                                          width: 105,
                                          height: 105,
                                          url: category?.imageUrl ?? '',
                                          boxFit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  PfText(
                                    text:
                                        state.popularCategories?[index].name ??
                                            '',
                                    variant: PfTextStyleVariant.bodyLarge,
                                    fontWeight: FontWeight.bold,
                                  )
                                ],
                              );
                            },
                            onFetchData: () async {
                              await _cubit.fetchCategories();
                            },
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
