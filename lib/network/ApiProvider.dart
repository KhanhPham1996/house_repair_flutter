import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_ft_app/data/BaseApiResponse.dart';
import 'package:my_ft_app/data/Login/LoginResponse.dart';
import 'package:my_ft_app/data/wage_table/Wage.dart';
import 'package:my_ft_app/storage/SecureStorage.dart';
import 'package:my_ft_app/storage/StorageKey.dart';

import '../../data/Login/LoginRequest.dart';

class ApiProvider {
  final SecureStorage _storageService = SecureStorage();

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: 'https://api-houserp.brickmate.kr/api',
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));

  Future<BaseApiResponse<LoginData>> login(LoginRequest loginRequest) async {
    try {
      Response response =
      await _dio.post('/engineer/login', data: loginRequest.toJson());
      return BaseApiResponse<LoginData>.fromJson(
          response.data, (data) => LoginData.fromJson(data));
    } on DioError catch (e) {
      if (e.response != null) {
        return BaseApiResponse.withError(e.response?.data);
      }
      return BaseApiResponse.withError(null);
    }
  }

  Future<BaseApiResponse<Wage>> getWages() async {
    var JWTkey = await _storageService.readSecureData(StorageKey.JWT.value);
    _dio.options.headers["Authorization"] = "Bearer ${JWTkey}";
    try {
      Response response = await _dio.get('/engineer/wage-table');

      return BaseApiResponse<Wage>.fromJson(
          response.data, (data) => Wage.fromJson(data));
    } on DioError catch (e) {
      if (e.response != null) {
        return BaseApiResponse.withError(e.response?.data);
      }
      return BaseApiResponse.withError(null);
    }


  }
}
