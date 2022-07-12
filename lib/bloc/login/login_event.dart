import 'package:equatable/equatable.dart';

import '../../data/Login/LoginRequest.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  final LoginRequest loginRequest;

  const Login({required this.loginRequest});

  List<Object?> get props => [loginRequest];
}


