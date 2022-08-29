import 'package:donghaeng/model/user.dart' as u;
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {
  Future<bool> addUser({required u.User user});

  Stream<u.User?> getUser();

  Future<u.User?> getUserByID({required String userID});

  Future<String?> getUserImagePath();

  Future<bool> updateUser({required u.User user});

  Future<String?> updateProfileImage({required XFile image});

  Future<bool> deleteUser();

  Future<void> logOut();
}
