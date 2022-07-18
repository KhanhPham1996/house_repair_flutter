part of 'get_wage_bloc.dart';

@immutable
abstract class GetWageEvent extends Equatable   {
  const GetWageEvent();
}

class GetWage extends GetWageEvent{
  const GetWage();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}