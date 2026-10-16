import '../../../../core/network/api_client.dart';
import '../models/product_details_model.dart';
import 'product_details_remote_data_source.dart';

class ProductDetailsRemoteDataSourceImp implements ProductDetailsRemoteDataSource {
  final ApiClient apiClient;

  ProductDetailsRemoteDataSourceImp({required this.apiClient});

  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await apiClient.dio.get(
      "products/$productId", // أو الـ Endpoint الخاص بتفاصيل المنتج حسب الـ API لديك
    );
    
    return ProductDetailsModel.fromJson(response.data);
  }
}