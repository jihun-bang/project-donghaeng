import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/repository/user_repository.dart';
import 'package:donghaeng/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/toast.dart';

class UserRepositoryImpl implements UserRepository {
  final auth = firebase_auth.FirebaseAuth.instance;
  final storage = FirebaseStorage.instance.ref('/profile');
  final users = FirebaseFirestore.instance.collection('users');

  UserRepositoryImpl();

  @override
  Future<bool> addUser({required User user}) async {
    try {
      await users.doc(auth.currentUser?.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      showToast(message: '회원가입에 실패했습니다.. 😭');
      return false;
    }
  }

  @override
  Stream<User?> getUser() {
    return users
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((event) => event.toUser());
  }

  @override
  Future<User?> getUserByID({required String userID}) async {
    final snapshot = await users.doc(userID).get();
    if (snapshot.exists) {
      return snapshot.toUser();
    } else {
      // todo: 에러 처리
      return null;
    }
  }

  @override
  Future<String?> getUserImagePath() async {
    try {
      final imageUrl =
          await storage.child("${auth.currentUser?.uid}.png").getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> updateUser({required User user}) async {
    try {
      await users.doc(auth.currentUser?.uid).update(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<String?> updateProfileImage({required XFile image}) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/png',
      );
      final ref = storage.child('/${auth.currentUser?.uid}.png');
      if (kIsWeb) {
        await ref.putData(await image.readAsBytes(), metadata);
      } else {
        await ref.putFile(File(image.path), metadata);
      }
      return await getUserImagePath();
    } catch (e) {
      print(e);
      showToast(message: '프로필 이미지 업데이트를 실패했습니다.. 😭');
      return null;
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await auth.currentUser?.delete();
      await users.doc(auth.currentUser?.uid).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

extension DocumentSnapX on DocumentSnapshot<Map<String, dynamic>> {
  User? toUser() {
    if (data() != null) {
      return User?.fromJson(data()!);
    }
    return null;
  }
}
