import 'package:equatable/equatable.dart';
import 'package:my_ft_app/data/LoginResponse.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse? loginResponse;

  const LoginSuccess({required this.loginResponse});

  @override
  List<Object> get props => [loginResponse!];



}

