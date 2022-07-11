part of 'form_validation_bloc.dart';

abstract class FormValidationState extends Equatable {
  const FormValidationState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class FormValidationInitial  extends FormValidationState{}
class UserNameEmpty extends FormValidationState {}
class PasswordEmpty extends FormValidationState {}
class FormCorrect extends FormValidationState {}






