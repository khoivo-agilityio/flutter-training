import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poltry_farm/shared/category_models.dart';

part 'home_sell_state.dart';

class HomeSellCubit extends Cubit<HomeSellState> {
  HomeSellCubit() : super(HomeSellState.initial());

  // TODO: Example repository call, replace with actual data source
  Future<List<PfCategoryModel>> fetchCategories({int page = 0}) async {
    emit(state.copyWith(status: HomeSellStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final categories = List.generate(
        15,
        (i) => PfCategoryModel(
            name: 'Owl $i',
            imageUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      );
      final result = state.popularCategories == null
          ? categories
          : [...state.popularCategories!, ...categories];
      emit(state.copyWith(
        status: HomeSellStatus.success,
        popularCategories: result,
      ));
      return result;
    } catch (e) {
      emit(state.copyWith(
        status: HomeSellStatus.failure,
        errorMessage: e.toString(),
      ));
      return state.popularCategories ?? [];
    }
  }
}
