import 'package:my_ft_app/data/wage_table/ApiWageResponse.dart';

import '../../data/Login/LoginRequest.dart';
import 'package:my_ft_app/data/Login/LoginResponse.dart';
import 'package:my_ft_app/network/ApiProvider.dart';

class LoginRepository {
  final ApiProvider _provider ;
  LoginRepository(this._provider);
  Future<ApiLoginResponse?> login(LoginRequest loginRequest) {
    return _provider.login(loginRequest);
  }

  Future<ApiWagResponse?> getWages() {
    return _provider.getWages();
  }
}

class NetworkError extends Error {}