import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/LoginRequest.dart';
import '../../data/form_validation/FieldError.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc extends Bloc<FormValidationEvent, FormValidationState>  {

  FormValidationBloc() : super(FormValidationInitial()) {
    on<FormScreenEventSubmit>((event, emit) async {
        if(event.loginRequest.username==null || event.loginRequest.username?.isEmpty == true){
          emit(UserNameEmpty());
          return;
        }
        if(event.loginRequest.password==null || event.loginRequest.password?.isEmpty == true){
          emit(PasswordEmpty());
        }
        else {
          emit(FormCorrect());
        }

    });
  }
}
