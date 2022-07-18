import 'package:my_ft_app/data/BaseApiResponse.dart';

import '../../data/wage_table/Wage.dart';
import '../ApiProvider.dart';

class WageRepository {
  final ApiProvider _provider ;
  WageRepository(this._provider);


  Future<BaseApiResponse<Wage>> getWages() {
    return _provider.getWages();
  }
}