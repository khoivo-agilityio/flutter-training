import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/shared/category_models.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/shared/product_models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  // TODO: Example repository call, replace with actual data source
  Future<List<PfCategoryModel>> fetchCategories({int page = 0}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final categories = List.generate(
        5,
        (i) => PfCategoryModel(
            name: 'Owl $i',
            imageUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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

  void searchFormChanged(String? value) {
    emit(
      state.copyWith(
        searchForm: state.searchForm.copyWith(
          text: value,
        ),
      ),
    );
  }
}
