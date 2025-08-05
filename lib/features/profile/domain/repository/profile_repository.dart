import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/profile/domain/entity/order_entity.dart';

abstract class IProfileRepository {
  DataState<List<OrderEntity>> getMyOrders();
}
