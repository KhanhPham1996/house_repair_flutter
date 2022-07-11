import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/login_event.dart';
import 'package:my_ft_app/bloc/login_state.dart';

import '../network/Login/LoginRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await loginRepository.login(event.loginRequest);
        emit(LoginSuccess(loginResponse: response));

      } catch (e) {
      //  emit(Login(failure: Failure(message: e.toString(), code: '')));
      }
    });
  }
}
