import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

abstract class UserRepository {
  Future<bool> addUser({required User user});

  Stream<User?> getUser();

  Future<User?> getUserByID({required String userID});

  Future<String?> getUserImagePath();

  Future<bool> updateUser({required User user});

  Future<String?> updateProfileImage({required XFile image});

  Future<bool> deleteUser();

  Future<void> logOut();
}
