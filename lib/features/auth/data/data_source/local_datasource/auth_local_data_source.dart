import 'package:dartz/dartz.dart';
import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  Future<void> signup(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.clear();
    await box.put(user.userId, user);
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    // Note: In a real app, you'd fetch the user from the remote data source first.
    // This local login is for offline functionality. Here, we assume the user
    // must have signed up or logged in online once before.
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    final users = box.values.toList();
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );

      // ✅ CORRECTED: Ensure the logged-in user's data is saved to the box
      // so the Profile screen can find it later.
      await box.clear();
      await box.put(user.userId, user);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(HiveTableConstant.sessionBox);
    await box.put('token', token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(HiveTableConstant.sessionBox);
    return box.get('token');
  }

  Future<void> deleteToken() async {
    final sessionBox = await Hive.openBox(HiveTableConstant.sessionBox);
    await sessionBox.clear();

    final userBox = await Hive.openBox<AuthHiveModel>(
      HiveTableConstant.userBox,
    );
    await userBox.clear();
  }

  Future<Either<Failure, AuthEntity>> getUser() async {
    try {
      final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      final authHiveModel = box.values.firstOrNull;

      if (authHiveModel != null) {
        final authEntity = authHiveModel.toEntity();
        return Right(authEntity);
      } else {
        return Left(Failure(error: 'User not found in local storage.'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
