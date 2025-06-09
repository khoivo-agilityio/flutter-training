part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<PfProductModel>? products;
  final List<PfCategoryModel>? popularCategories;

  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const [],
    this.popularCategories,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<PfProductModel>? products,
    List<PfCategoryModel>? popularCategories,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      popularCategories: popularCategories ?? this.popularCategories,
    );
  }

  factory HomeState.initial() {
    return const HomeState();
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, products, popularCategories];
}
