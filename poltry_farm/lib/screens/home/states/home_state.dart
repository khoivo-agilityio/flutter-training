part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<PfProductModel>? products;
  final List<PfCategoryModel>? popularCategories;
  final PfSearchTextFormFieldSubState searchForm;

  const HomeState({
    this.status = HomeStatus.initial,
    required this.searchForm,
    this.products = const [],
    this.popularCategories,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<PfProductModel>? products,
    List<PfCategoryModel>? popularCategories,
    PfSearchTextFormFieldSubState? searchForm,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      popularCategories: popularCategories ?? this.popularCategories,
      searchForm: searchForm ?? this.searchForm,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      status: HomeStatus.initial,
      popularCategories: const [],
      products: const [],
      searchForm: PfSearchTextFormFieldSubState(
        semanticsLabel: S.current.formSearchSemanticLabel,
        hintText: S.current.formSearchHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      ),
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, products, popularCategories];
}
