import 'package:image_picker/image_picker.dart';

abstract class StorageRemoteDataSource {
  StorageRemoteDataSource();

  /// User
  Future<String> getUserImagePath({required String id});
  Future<String> updateProfileImage({required XFile image});
}
