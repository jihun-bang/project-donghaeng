import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donghaeng/data/repository/user_repository.dart';
import 'package:donghaeng/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../utils/toast.dart';

class UserRepositoryImpl implements UserRepository {
  final auth = firebase_auth.FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
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
  Future<User?> getUser() async {
    try {
      return await users
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) => value.toUser());
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
  User toUser() {
    return User.fromJson(data()!);
  }
}
