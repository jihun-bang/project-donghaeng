import 'package:donghaeng/model/user.dart' as u;

abstract class UserRepository {
  Future<bool> addUser({required u.User user});

  Stream<u.User?> getUser();

  Future<bool> updateUser({required u.User user});

  Future<bool> deleteUser();

  Future<void> logOut();
}
