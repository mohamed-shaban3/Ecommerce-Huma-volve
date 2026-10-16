import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final int limit = 10;
  int offset = 0;
  bool hasMore = true;
  bool isLoadingMore = false;
  int? selectedCategory;
  List<HomeCategoryEntity> categories = [];

  final List<HomeProductEntity> _products = [];

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitialState());

  Future<void> loadHomeData() async {
    emit(CategoryLoadingState());

    final categoriesResult = await getCategoriesUseCase.invoke();
    int? id = 0;
    categoriesResult.fold(
      (failure) {
        emit(CategoryErrorState(failure.failureMessage));
      },
      (categoriesResult) {
        categories = categoriesResult;
        id = categoriesResult.first.id;
        print("List of data : ${categoriesResult.first.id}");
        emit(CategorySuccessState(categoriesResult));
      },
    );

    await getProductsByCategoryId(id!);
  }

  Future<void> getProductsByCategoryId(int id) async {
    _products.clear();
    offset = 0;
    isLoadingMore = false;
    emit(ProductLoadingState());
    hasMore = true;
    final result = await getProductsUseCase.invoke(
      id,
      limit: limit,
      offset: offset,
    );
    result.fold(
      (failure) {
        emit(ProductErrorState(failure.failureMessage));
      },
      (products) {
        _products.addAll(products);
        offset = products.length;
        if (products.length < limit) {
          hasMore = false;
        }
        selectedCategory = id;
        emit(ProductSuccessState(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    emit(ProductLoadingMoreState());

    final result = await getProductsUseCase.invoke(
      selectedCategory,
      limit: limit,
      offset: offset,
    );
    isLoadingMore = false;
    result.fold(
      (failure) {
        emit(ProductLoadingMoreErrorState(failure.failureMessage));
      },
      (newProducts) {
        _products.addAll(newProducts);
        offset += newProducts.length;
        if (newProducts.length < limit) {
          hasMore = false;
        }
        emit(ProductSuccessState(List.from(_products)));
      },
    );
  }
}
