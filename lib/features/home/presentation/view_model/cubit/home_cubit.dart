import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitialState());

  void loadHomeData() async {
    int? categoryId = 0;
    emit(CategoryLoadingState());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoryErrorState(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategorySuccessState(categories));
      },
    );

    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductErrorState(failure.failureMessage));
      },
      (products) {
        emit(ProductSuccessState(products));
      },
    );
  }

  void getProductsByCategory(int id) async {
    emit(ProductLoadingState());

    final products = await getProductsUseCase.invoke(id);
    products.fold(
      (failure) {
        emit(ProductErrorState(failure.failureMessage));
      },
      (products) {
        emit(ProductSuccessState(products));
      },
    );
  }
}
