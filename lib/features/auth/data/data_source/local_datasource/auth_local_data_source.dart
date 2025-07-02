import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  Future<void> signup(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    final users = box.values.toList();
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      return user;
    } catch (e) {
      return null;
    }
  }

  // NEW: Save the auth token to a separate session box.
  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(HiveTableConstant.sessionBox);
    await box.put('token', token);
  }

  // NEW: Get the auth token from the session box.
  Future<String?> getToken() async {
    final box = await Hive.openBox(HiveTableConstant.sessionBox);
    return box.get('token');
  }
}
