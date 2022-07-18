import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/login/login_event.dart';
import 'package:my_ft_app/bloc/login/login_state.dart';
import 'package:my_ft_app/storage/SecureStorage.dart';

import '../../network/Login/LoginRepository.dart';
import '../../storage/StorageItem.dart';
import '../../storage/StorageKey.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final SecureStorage _storageService = SecureStorage();

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      try {
          emit(LoginLoading());
          final response = await loginRepository.login(event.loginRequest);
          if (response.success == true) {
            _storageService.deleteAllSecureData();
            if (response.data?.accessToken != null) {
              var accessToken = response.data?.accessToken;
              _storageService.writeSecureData(
                  StorageItem(StorageKey.JWT.value, accessToken!));
            }
            emit(LoginSuccess(loginResponse: response.data));
            await _storageService.readAllSecureData();
          }
          else if (response.error?.success == false &&  response.error?.message!=null) {
            {
              emit(LoginFail(errorMess: response.error?.message!));
            }
          }
        } catch (e) {
          emit(LoginFail(errorMess: e.toString()));
        }
      },
    );
  }
}
