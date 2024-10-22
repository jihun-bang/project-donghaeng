import 'package:donghaeng/data/datasources/store_remote_data_source.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/storage_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final StoreRemoteDataSource storeRemoteDataSource;
  final StorageRemoteDataSource storageRemoteDataSource;

  UserRepositoryImpl(
      {required this.storeRemoteDataSource,
      required this.storageRemoteDataSource});

  @override
  Future<bool> add({required UserModel user}) async {
    try {
      await storeRemoteDataSource.addUser(user: user);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<UserModel?> getByStream() {
    return storeRemoteDataSource.getUserByStream();
  }

  @override
  Future<UserModel?> get({String? id}) async {
    try {
      return await storeRemoteDataSource.getUser(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update({required UserModel user}) async {
    try {
      await storeRemoteDataSource.updateUser(user: user);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete() async {
    try {
      await storeRemoteDataSource.deleteUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getImagePath({required String id}) async {
    try {
      return await storageRemoteDataSource.getUserImagePath(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> updateProfileImage(
      {required XFile image, required bool isProfile}) async {
    try {
      return await storageRemoteDataSource.updateProfileImage(
          image: image, isProfile: isProfile);
    } catch (e) {
      return null;
    }
  }
}
