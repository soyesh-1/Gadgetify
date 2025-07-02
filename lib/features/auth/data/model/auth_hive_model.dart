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
  final String name; 

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.name,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  AuthEntity toEntity() => AuthEntity(
    id: userId,
    name: name, 
    email: email,
    password: password,
  );

  factory AuthHiveModel.fromEntity(AuthEntity entity) => AuthHiveModel(
    userId: entity.id,
    name: entity.name,
    email: entity.email,
    password: entity.password,
  );

  @override
  List<Object?> get props => [userId, name, email, password];
}
