import 'package:cat_app/src/dao/auth_dao.dart';
import 'package:cat_app/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({
    required AuthService authService,
    required AuthDao authDao,
  })  : _authService = authService,
        _authDao = authDao;

  final AuthService _authService;
  final AuthDao _authDao;

  Future<bool> get isLogined async => await _authDao.hasAccessToken();

  Future<bool> login() async {
    final User? user = await _authService.signInWithGoogle();

    if (user != null) {
      await _authDao.saveAccessToken(user.uid);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.signOut();
    await _authDao.deleteAccessToken();
  }
}
