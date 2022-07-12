import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_ft_app/data/wage_table/ApiWageResponse.dart';
import '../../data/Login/LoginRequest.dart';
import 'package:my_ft_app/data/Login/LoginResponse.dart';
import 'package:my_ft_app/storage/SecureStorage.dart';
import 'package:my_ft_app/storage/StorageKey.dart';

class ApiProvider {
  final SecureStorage _storageService = SecureStorage();
  var a = Map<String,String>();

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      baseUrl:'https://api-houserp.brickmate.kr/api',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),

    )
  );



  Future<ApiLoginResponse?> login(LoginRequest loginRequest) async {

    try {
      Response response = await _dio.post(
          '/engineer/login', data: loginRequest.toJson());

      return  ApiLoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiLoginResponse.withError("Data not found / Connection issue");
    }
  }

  Future<ApiWagResponse?> getWages() async {
    var JWTkey = await _storageService.readSecureData(StorageKey.JWT.value);
    _dio.options.headers["Authorization"] = "Bearer ${JWTkey}";
    try {
      Response response = await _dio.get(
          '/engineer/wage-table');

      return  ApiWagResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiWagResponse.withError("Data not found / Connection issue");
    }
  }


  void dioConfig(){
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }


}