import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDao {
  const AuthDao({required FlutterSecureStorage storage})
      : _flutterSecureStorage = storage;

  final FlutterSecureStorage _flutterSecureStorage;

  static const _accessTokenKey = 'accessToken';

  Future<void> saveAccessToken(String accessToken) =>
      _flutterSecureStorage.write(key: _accessTokenKey, value: accessToken);

  Future<void> deleteAccessToken() =>
      _flutterSecureStorage.delete(key: _accessTokenKey);

  Future<bool> hasAccessToken() => _flutterSecureStorage
      .read(key: _accessTokenKey)
      .then((value) => value != null);
}
