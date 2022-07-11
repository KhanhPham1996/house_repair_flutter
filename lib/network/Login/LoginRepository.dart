import 'package:my_ft_app/data/LoginRequest.dart';
import 'package:my_ft_app/data/LoginResponse.dart';
import 'package:my_ft_app/network/ApiProvider.dart';

class LoginRepository {
  final _provider = ApiProvider();

  Future<ApiLoginResponse?> login(LoginRequest loginRequest) {
    return _provider.login(loginRequest);
  }
}

class NetworkError extends Error {}