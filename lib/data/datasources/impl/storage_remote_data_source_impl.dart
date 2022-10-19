import 'dart:io';

import 'package:donghaeng/data/datasources/storage_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/toast.dart';

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final auth = FirebaseAuth.instance;
  final profileRef = FirebaseStorage.instance.ref('/profile');

  @override
  Future<String> getUserImagePath({String? id, bool isProfile = true}) async {
    try {
      final imageUrl = await profileRef
          .child(
              '${auth.currentUser?.uid}/${isProfile ? 'profile' : 'background'}.png')
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<String> updateProfileImage(
      {required XFile image, required bool isProfile}) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/png',
      );
      final ref = profileRef.child(
          '${auth.currentUser?.uid}/${isProfile ? 'profile' : 'background'}.png');
      if (kIsWeb) {
        await ref.putData(await image.readAsBytes(), metadata);
      } else {
        await ref.putFile(File(image.path), metadata);
      }
      return await getUserImagePath(isProfile: isProfile);
    } catch (e) {
      print(e);
      showToast(message: '프로필 이미지 업데이트를 실패했습니다.. 😭');
      throw Exception(e);
    }
  }
}
