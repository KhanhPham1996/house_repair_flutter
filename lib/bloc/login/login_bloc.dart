import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/login/login_event.dart';
import 'package:my_ft_app/bloc/login/login_state.dart';

import '../../network/Login/LoginRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      try {
        emit(LoginLoading());

        final response = await loginRepository.login(event.loginRequest);
        if (response != null && response.success == true) {
          emit(LoginSuccess(loginResponse: response.data));
        } else if (response != null && response.success == false) {
          {
            emit(LoginFail(errorMess: response.message));
          }
        } else {
          emit(LoginFail(errorMess: response?.error));
        }
      } catch (e) {
        emit(LoginFail(errorMess: e.toString()));
      }
    });
  }
}
