import 'package:cat_app/src/dao/auth_dao.dart';
import 'package:cat_app/src/services/auth_services/auth_local_service.dart';
import 'package:cat_app/src/services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class AuthRepository {
  AuthRepository({
    required AuthService authService,
    required AuthDao authDao,
    required AuthLocalService authLocalService,
  })  : _authService = authService,
        _authDao = authDao,
        _authLocalService = authLocalService;

  final AuthService _authService;
  final AuthDao _authDao;
  final AuthLocalService _authLocalService;

  Future<bool> get isLoggedIn => _authDao.hasAccessToken();

  Future<UserModel> get user => _authLocalService.getUser();

  Future<bool> loginWithGoogle() async {
    try {
      final User? user = await _authService.signInWithGoogle();

      if (user == null) {
        return false;
      }

      await _authDao.saveAccessToken(await user.getIdToken());

      final userModel = UserModel(
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
        id: user.uid,
      );

      _authLocalService.saveUser(userModel);

      return true;
    } catch (e) {
      throw 'Oops, signing in with Google is failed: $e';
    }
  }

  Future<void> logout() => Future.wait([
        _authService.signOut(),
        _authDao.deleteAccessToken(),
      ]);
}
