import 'package:donghaeng/model/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../data/di/locator.dart';
import '../data/repository/user_repository.dart';
import '../utils/toast.dart';

class UserViewModel with ChangeNotifier {
  final _repository = sl<UserRepository>();

  bool _getUserLoading = false;

  bool get getUserLoading => _getUserLoading;

  u.User? _user;

  u.User? get user => _user;

  final List<User> users = [];

  UserViewModel();

  Future<bool> addUser(String id) async {
    return await _repository.addUser(user: u.User(id: id)).then((result) {
      if (!result) {
        showToast(message: '회원 가입를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  void getUser() {
    _getUserLoading = true;
    _repository.getUser().listen((user) {
      print('${hashCode} listen = ${user?.toJson()}');
      _user = user;
      _getUserLoading = false;
      notifyListeners();
    });
  }

  Future<bool> updateUser({u.User? user}) async {
    return await _repository.updateUser(user: user ?? _user!).then((result) {
      if (!result) {
        showToast(message: '프로필 업데이트를 실패하였습니다.. 😥');
      }
      return result;
    });
  }

  void logout() {
    _repository.logOut();
  }
}
