import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

class LoginResponseModel {
  final String token;
  final AuthEntity user;

  LoginResponseModel({required this.token, required this.user});
}
