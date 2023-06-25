import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDao {
  const AuthDao({required FlutterSecureStorage storage})
      : _flutterSecureStorage = storage;

  final FlutterSecureStorage _flutterSecureStorage;

  static const _accessTokenKey = 'accessToken';

  Future<void> saveAccessToken(String accessToken) async {
    await _flutterSecureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> deleteAccessToken() async {
    await _flutterSecureStorage.delete(key: _accessTokenKey);
  }

  Future<bool> hasAccessToken() async {
    final String? accessToken =
        await _flutterSecureStorage.read(key: _accessTokenKey);
    return accessToken != null;
  }
}
