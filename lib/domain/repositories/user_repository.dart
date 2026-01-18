import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
  Future<List<UserEntity>> getUsers();
  Future<UserEntity> getUserById(int id);
}