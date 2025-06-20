import 'package:equatable/equatable.dart';
import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  AuthHiveModel({String? userId, required this.email, required this.password})
    : userId = userId ?? const Uuid().v4();

  // Convert Hive Model to Entity (Domain object)
  AuthEntity toEntity() =>
      AuthEntity(id: userId, email: email, password: password);

  // Convert Entity (Domain object) to Hive Model
  factory AuthHiveModel.fromEntity(AuthEntity entity) => AuthHiveModel(
    userId: entity.id,
    email: entity.email,
    password: entity.password,
  );

  @override
  List<Object?> get props => [userId, email, password];
}
