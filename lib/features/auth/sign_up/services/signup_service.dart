import 'package:ecommerce_app_huma_volve/core/constants/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';

class SignupService {
  ApiClient apiClient;
  SignupService(this.apiClient);
  Future<SignupResModel> signup(SignupReqModel signupReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoint.signupEndpoint,
      data: {
        'name': signupReqModel.name,
        'email': signupReqModel.email,
        'password': signupReqModel.password,
        'avatar': "https://i.imgur.com/LDOO4Qs.jpg",
      },
    );
    final Map<String, dynamic> jsonData = response.data;
    final dartData = SignupResModel.fromJson(jsonData);
    return dartData;
  }
}
