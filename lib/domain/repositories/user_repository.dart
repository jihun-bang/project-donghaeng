import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

abstract class UserRepository {
  Future<bool> add({required User user});

  Stream<User?> getByStream();

  Future<User?> get({required String id});

  Future<String?> getImagePath({required String id});

  Future<bool> update({required User user});

  Future<String?> updateProfileImage({required XFile image});

  Future<bool> delete();
}
