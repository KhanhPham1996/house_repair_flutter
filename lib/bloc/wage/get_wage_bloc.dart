import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_ft_app/network/Wage/WageRepository.dart';

import '../../data/wage_table/Wage.dart';

part 'get_wage_event.dart';

part 'get_wage_state.dart';

class GetWageBloc extends Bloc<GetWageEvent, GetWageState> {
  final WageRepository wageRepository;

  GetWageBloc({required this.wageRepository}) : super(GetWageInitial()) {
    on<GetWageEvent>((event, emit) async {
      emit(GetWageLoading());
      try {
        final response = await wageRepository.getWages();
        if (response.success == true) {
          emit(GetWageLSuccess(wage: response.data));
        } else if (response.success == false && response.error?.message!=null) {
          {
            emit(GetWageFail(errorMess: response.error?.message));
          }

        }
      } catch (e) {
        emit(GetWageFail(errorMess: e.toString()));
      }
    });
  }
}
