import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/profile/domain/entity/order_entity.dart';
import 'package:gadgetify/features/profile/domain/repository/profile_repository.dart';

class GetMyOrdersUseCase extends UseCase<List<OrderEntity>, NoParams> {
  final IProfileRepository _repository;

  GetMyOrdersUseCase(this._repository);

  @override
  DataState<List<OrderEntity>> call(NoParams params) async {
    return await _repository.getMyOrders();
  }
}
