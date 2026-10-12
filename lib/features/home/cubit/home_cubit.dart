import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_sevice.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeSevice homeService;
  HomeCubit(this.homeService) : super(HomeInitialState());

  void loadHomeData() async {
    emit(CategoryLoadingState());
    try {
      final categories = await homeService.getCategories();
      emit(CategorySuccessState(categories));
      final products = await homeService.getProducts(categories[0].id);
      emit(ProductSuccessState(products));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
  void getProductsByCategory(int categoryId) async {
  emit(ProductLoadingState());
  try {
    final products = await homeService.getProducts(categoryId);
    emit(ProductSuccessState(products));
  } catch (e) {
    emit(ProductErrorState(e.toString()));
  }
}
}
