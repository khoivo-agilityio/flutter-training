import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poltry_farm/shared/category_models.dart';
import 'package:poltry_farm/shared/product_models.dart';
import 'package:poltry_farm/widgets/form_input.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  // TODO: Example repository call, replace with actual data source
  Future<List<PfCategoryModel>> fetchCategories({int page = 0}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final categories = _mockCategories;
      final result = state.popularCategories == null
          ? categories
          : [...state.popularCategories!, ...categories];
      emit(state.copyWith(
        status: HomeStatus.success,
        popularCategories: result,
      ));
      return result;
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
      return state.popularCategories ?? [];
    }
  }

  // TODO: Example repository call, replace with actual data source
  Future<List<PfProductModel>> fetchRecommandations({int page = 0}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final products = List.generate(
        6,
        (i) => PfProductModel(
            name: 'Poultry Name $i',
            quantity: i,
            location: 'Location $i',
            imageUrl:
                'https://ik.imagekit.io/stoxduoxkg/Mask%20group.png?updatedAt=1750698400659'),
      );
      final result =
          state.products == null ? products : [...state.products!, ...products];
      emit(state.copyWith(
        status: HomeStatus.success,
        products: result,
      ));
      return products;
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
      return state.products ?? [];
    }
  }
}

final _mockCategories = <PfCategoryModel>[
  const PfCategoryModel(
    name: 'Birds',
    imageUrl:
        'https://ik.imagekit.io/stoxduoxkg/chick%201.png?updatedAt=1750697868221', // Flock of birds
  ),
  const PfCategoryModel(
    name: 'Eggs',
    imageUrl:
        'https://ik.imagekit.io/stoxduoxkg/eggs%20(2)%201.png?updatedAt=1750697868152', // Eggs in a basket
  ),
  const PfCategoryModel(
    name: 'Chicks',
    imageUrl:
        'https://ik.imagekit.io/stoxduoxkg/birds%201.png?updatedAt=1750697867969', // Chicks
  ),
  const PfCategoryModel(
    name: 'Ducks',
    imageUrl:
        'https://ik.imagekit.io/stoxduoxkg/duck%201.png?updatedAt=1750697868135', // Duck
  ),
  const PfCategoryModel(
    name: 'Cow',
    imageUrl:
        'https://ik.imagekit.io/stoxduoxkg/pngtree-holstein-cow-png-image_15744446.png?updatedAt=1750698006671', // Cow
  ),
];
