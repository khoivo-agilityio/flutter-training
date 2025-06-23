part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<PfProductModel>? products;
  final List<PfCategoryModel>? popularCategories;
  final PfProducts searchForm;

  const HomeState({
    this.status = HomeStatus.initial,
    this.searchForm = const PfProducts.pure(),
    this.products = const [],
    this.popularCategories,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<PfProductModel>? products,
    List<PfCategoryModel>? popularCategories,
    PfProducts? searchForm,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      popularCategories: popularCategories ?? this.popularCategories,
      searchForm: searchForm ?? this.searchForm,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, products, popularCategories];
}
