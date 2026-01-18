import '../models/user_model.dart';

abstract class LocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
  Future<bool> isFirstTime();
  Future<void> setFirstTime(bool isFirstTime);
}

class LocalDataSourceImpl implements LocalDataSource {
  UserModel? _cachedUser;
  bool _isFirstTime = true;

  @override
  Future<UserModel?> getCachedUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cachedUser = user;
  }

  @override
  Future<void> clearCache() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cachedUser = null;
  }

  @override
  Future<bool> isFirstTime() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _isFirstTime;
  }

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _isFirstTime = isFirstTime;
  }
}