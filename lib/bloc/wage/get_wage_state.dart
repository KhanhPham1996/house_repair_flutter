part of 'get_wage_bloc.dart';

@immutable
abstract class GetWageState extends Equatable  {
  const GetWageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class GetWageInitial extends GetWageState {}
class GetWageLoading extends GetWageState {}


class GetWageLSuccess extends GetWageState {
  final Wage? wage;

  const GetWageLSuccess({required this.wage});

  @override
  List<Object> get props => [wage!];

}

class GetWageFail extends GetWageState {
  final String? errorMess;
  const GetWageFail({required this.errorMess});


}
