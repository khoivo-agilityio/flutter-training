import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/screens/home/states/home_cubit.dart';

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
      expect(homeCubit.state, HomeState.initial());
    });

    blocTest<HomeCubit, HomeState>(
      'emits state with updated search text when searchFormChanged is called',
      build: () => HomeCubit(),
      act: (cubit) => cubit.searchFormChanged('chicken'),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.searchForm.text, 'searchForm.text', 'chicken'),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] with categories when fetchCategories is called',
      build: () => HomeCubit(),
      act: (cubit) => cubit.fetchCategories(),
      wait: const Duration(milliseconds: 600), // wait for delay
      expect: () => [
        isA<HomeState>().having((s) => s.status, 'status', HomeStatus.loading),
        isA<HomeState>()
            .having((s) => s.status, 'status', HomeStatus.success)
            .having((s) => s.popularCategories?.length,
                'popularCategories.length', 5),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] with products when fetchRecommandations is called',
      build: () => HomeCubit(),
      act: (cubit) => cubit.fetchRecommandations(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        isA<HomeState>().having((s) => s.status, 'status', HomeStatus.loading),
        isA<HomeState>()
            .having((s) => s.status, 'status', HomeStatus.success)
            .having((s) => s.products?.length, 'products.length', 6),
      ],
    );
  });
}
