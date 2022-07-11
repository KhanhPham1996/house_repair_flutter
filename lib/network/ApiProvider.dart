import 'package:dio/dio.dart';
import 'package:my_ft_app/data/LoginRequest.dart';
import 'package:my_ft_app/data/LoginResponse.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api-houserp.brickmate.kr/api/engineer';

  Future<ApiLoginResponse?> login(LoginRequest loginRequest) async {
    try {
      Response response = await _dio.post(
          '$_url/login', data: loginRequest.toJson());

      return  ApiLoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiLoginResponse.withError("Data not found / Connection issue");
    }
  }
}