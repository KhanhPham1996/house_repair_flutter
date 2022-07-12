import '../../data/wage_table/ApiWageResponse.dart';
import '../ApiProvider.dart';

class WageRepository {
  final ApiProvider _provider ;
  WageRepository(this._provider);


  Future<ApiWagResponse?> getWages() {
    return _provider.getWages();
  }
}