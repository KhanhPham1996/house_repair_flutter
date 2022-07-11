part of 'form_validation_bloc.dart';

abstract class FormValidationEvent extends Equatable {
  const FormValidationEvent();
}
class FormScreenEventSubmit extends FormValidationEvent{
  final LoginRequest loginRequest;
  const FormScreenEventSubmit({required this.loginRequest});

  @override
  // TODO: implement props
  List<Object?> get props =>[loginRequest];

}
