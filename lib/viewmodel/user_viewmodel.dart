import 'package:donghaeng/model/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../data/di/locator.dart';
import '../data/repository/user_repository.dart';
import '../utils/toast.dart';

class UserViewModel with ChangeNotifier {
  final repository = sl<UserRepository>();

  bool _getUserLoading = false;
  bool get getUserLoading => _getUserLoading;

  u.User? _user;
  u.User? get user => _user;

  final List<User> users = [];

  UserViewModel();

  Future<bool> addUser(String id) async {
    return await repository.addUser(user: u.User(id: id)).then((result) {
      if (!result) {
        showToast(message: '회원 가입를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  void getUser() {
    _getUserLoading = true;
    repository.getUser().listen((user) {
      if (user?.toJson().toString() != _user?.toJson().toString()) {
        print('[UserViewModel] ${user?.toJson()}');
        _user = user;
        _getUserLoading = false;
        notifyListeners();
      }
    });
  }

  Future<bool> updateUser({u.User? user}) async {
    return await repository.updateUser(user: user ?? _user!).then((result) {
      if (!result) {
        showToast(message: '프로필 업데이트를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  void logout() {
    repository.logOut();
  }
}
