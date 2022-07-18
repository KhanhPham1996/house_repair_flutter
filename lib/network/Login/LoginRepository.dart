import 'package:my_ft_app/data/BaseApiResponse.dart';
import 'package:my_ft_app/data/wage_table/Wage.dart';

import '../../data/Login/LoginRequest.dart';
import 'package:my_ft_app/data/Login/LoginResponse.dart';
import 'package:my_ft_app/network/ApiProvider.dart';

class LoginRepository {
  final ApiProvider _provider ;
  LoginRepository(this._provider);
  Future<BaseApiResponse<LoginData>> login(LoginRequest loginRequest) {
    return _provider.login(loginRequest);
  }

}

class NetworkError extends Error {}