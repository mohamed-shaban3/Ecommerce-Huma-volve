import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitialState());

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoadingState());
    final result = await getProductDetailsUseCase.invoke(productId);
    
    result.fold(
      (failure) => emit(ProductDetailsErrorState(failure.failureMessage)),
      (product) => emit(ProductDetailsSuccessState(product)),
    );
  }
}