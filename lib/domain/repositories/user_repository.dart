import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

abstract class UserRepository {
  Future<bool> add({required UserModel user});

  Stream<UserModel?> getByStream();

  Future<UserModel?> get({required String id});

  Future<String?> getImagePath({required String id});

  Future<bool> update({required UserModel user});

  Future<String?> updateProfileImage(
      {required XFile image, required bool isProfile});

  Future<bool> delete();
}
