import 'dart:convert';

import 'package:donghaeng/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../injection.dart';
import '../../utils/toast.dart';

class UserViewModel with ChangeNotifier {
  final repository = sl<UserRepository>();

  bool _getUserLoading = false;
  bool get getUserLoading => _getUserLoading;

  UserModel? _user;
  UserModel? get user => _user;

  final Map<String, String> _userImagePathMap = {};
  Map<String, String> get userImagePathMap => _userImagePathMap;

  final List<User> users = [];

  UserViewModel() {
    getUser();
  }

  Future<bool> addUser(String id) async {
    return await repository.add(user: UserModel(id: id)).then((result) {
      if (!result) {
        showToast(message: '회원 가입를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  Future<UserModel?> getUser() async {
    _getUserLoading = true;
    notifyListeners();
    // repository.getByStream().listen((user) {
    //   _getUserLoading = false;
    //   if (user?.toJson().toString() != _user?.toJson().toString()) {
    //     print('[UserViewModel] ${user?.toJson()}');
    //     _user = user;
    //   }
    //   notifyListeners();
    // });
    final saveUser = await storage.read(key: 'user');
    final user = saveUser != null
        ? UserModel.fromJson(jsonDecode(saveUser))
        : await repository.get(id: 'OewS7oR7wQdWdp4suPOsfvRCXgH2');
    await storage.write(key: 'user', value: jsonEncode(user?.toJson()));
    _user = user;
    _getUserLoading = false;
    notifyListeners();
    print('[UserViewModel] ${user?.toJson()}');
    return user;
  }

  getMemberImagePath({required List<String>? memberIDs}) {
    if (memberIDs == null) {
      return;
    }

    for (var memberID in memberIDs) {
      getImagePath(userID: memberID);
    }

    notifyListeners();
  }

  getImagePath({required String userID}) async {
    if (!_userImagePathMap.containsKey(userID)) {
      final user = await repository.get(id: userID);
      _userImagePathMap[userID] = user?.imagePath ?? "";
    }
  }

  Future<bool> updateUser({UserModel? user}) async {
    return await repository.update(user: user ?? _user!).then((result) {
      if (!result) {
        showToast(message: '프로필 업데이트를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
