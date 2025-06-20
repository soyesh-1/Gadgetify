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
      await box.close();
      return user;
    } catch (e) {
      await box.close();
      return null;
    }
  }
}
