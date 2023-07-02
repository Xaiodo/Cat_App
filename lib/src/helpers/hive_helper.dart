import 'package:cat_app/src/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../pages/bottom_navigation/pages/home/model/cat.dart';
import '../values/app_constants.dart';

abstract class HiveHelper {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(CatAdapter());
    Hive.registerAdapter(UserModelAdapter());

    // Open Boxes
    await Future.wait([
      Hive.openBox<Cat>(Strings.catBox),
      Hive.openBox<UserModel>(Strings.userBox),
    ]);
  }
}
