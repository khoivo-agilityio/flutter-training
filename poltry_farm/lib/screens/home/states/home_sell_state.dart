part of 'home_sell_cubit.dart';

enum HomeSellStatus { initial, loading, success, failure }

class HomeSellState extends Equatable {
  final HomeSellStatus status;
  final String? errorMessage;

  final List<PfCategoryModel>? popularCategories;

  const HomeSellState({
    this.status = HomeSellStatus.initial,
    this.popularCategories,
    this.errorMessage,
  });

  HomeSellState copyWith({
    HomeSellStatus? status,
    String? errorMessage,
    List<PfCategoryModel>? popularCategories,
  }) {
    return HomeSellState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      popularCategories: popularCategories ?? this.popularCategories,
    );
  }

  factory HomeSellState.initial() {
    return const HomeSellState(
      status: HomeSellStatus.initial,
      popularCategories: [],
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, popularCategories];
}
