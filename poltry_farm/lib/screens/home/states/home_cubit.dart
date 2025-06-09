import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poltry_farm/shared/category_models.dart';
import 'package:poltry_farm/shared/product_models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  // Example repository call, replace with your actual data source
  Future<List<PfCategoryModel>> fetchCategories(int page) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final categories = List.generate(
        10,
        (i) => PfCategoryModel(
            name: 'Chicken ${i + (page - 1) * 10}',
            imageUrl:
                'https://cdn.pixabay.com/photo/2017/02/20/18/03/rooster-2085777_1280.jpg'),
      );
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
}
