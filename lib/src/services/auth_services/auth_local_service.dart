import 'package:cat_app/src/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthLocalService {
  AuthLocalService({required Box box}) : _box = box;

  final Box _box;

  Future<void> saveUser(UserModel user) => _box.put('user', user);

  Future<UserModel> getUser() => Future.value(
        _box.get('user', defaultValue: UserModel.empty()),
      );
}
