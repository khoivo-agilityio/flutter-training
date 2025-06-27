import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/screens/home/states/home_cubit.dart';
import '../constant.dart';

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // fake the localization delegate
      S.load(const Locale('en'));
      homeCubit = HomeCubit();
    });

    tearDown(() {
      homeCubit.close();
    });

    test('initial state is correct', () {
      expect(homeCubit.state, const HomeState());
    });

    const expectedCategoryCount = 5;
    const expectedProductCount = 6;

    blocTest<HomeCubit, HomeState>(
      '''Scenario: Fetch categories
Given a HomeCubit instance
When fetchCategories is called
Then it should emit [loading, success] with $expectedCategoryCount categories''',
      build: () => HomeCubit(),
      act: (cubit) => cubit.fetchCategories(),
      wait: const Duration(milliseconds: 600), // wait for delay
      expect: () => [
        isA<HomeState>().having((s) => s.status, 'status', HomeStatus.loading),
        isA<HomeState>()
            .having((s) => s.status, 'status', HomeStatus.success)
            .having((s) => s.popularCategories?.length,
                'popularCategories.length', expectedCategoryCount),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      '''Scenario: Fetch product recommendations
Given a HomeCubit instance
When fetchRecommandations is called
Then it should emit [loading, success] with $expectedProductCount products''',
      build: () => HomeCubit(),
      act: (cubit) => cubit.fetchRecommandations(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        isA<HomeState>().having((s) => s.status, 'status', HomeStatus.loading),
        isA<HomeState>()
            .having((s) => s.status, 'status', HomeStatus.success)
            .having((s) => s.products?.length, 'products.length', expectedProductCount),
      ],
    );
  });
}
