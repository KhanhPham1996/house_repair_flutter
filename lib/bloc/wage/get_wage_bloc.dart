import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_ft_app/network/Wage/WageRepository.dart';

import '../../data/wage_table/ApiWageResponse.dart';

part 'get_wage_event.dart';

part 'get_wage_state.dart';

class GetWageBloc extends Bloc<GetWageEvent, GetWageState> {
  final WageRepository wageRepository;

  GetWageBloc({required this.wageRepository}) : super(GetWageInitial()) {
    on<GetWageEvent>((event, emit) async {
      emit(GetWageLoading());
      try {
        final response = await wageRepository.getWages();
        if (response != null && response.success == true) {
          emit(GetWageLSuccess(wage: response.data));
        } else if (response != null && response.success == false) {
          {
            emit(GetWageFail(errorMess: response.message));
          }
        } else {
          emit(GetWageFail(errorMess: response?.error));
        }
      } catch (e) {
        emit(GetWageFail(errorMess: e.toString()));
      }
    });
  }
}
