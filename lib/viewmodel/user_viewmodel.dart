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

  final Map<String, String> _userImagePathMap = {};
  Map<String, String> get userImagePathMap => _userImagePathMap;

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

  getMemberImagePath({required List<String>? memberIDs}) {
    if (memberIDs == null) {
      return;
    }

    for (var memberID in memberIDs) {
      getImagePath(userID: memberID);
    }

    // notifyListeners(); todo: 이걸 빼도 되는지 모르겠네여.
  }

  getImagePath({required String userID}) async {
    const defaultImagePath = 'https://avatars.githubusercontent.com/u/38811086?v=4';

    if (! _userImagePathMap.containsKey(userID)) {
      final user = await repository.getUserByID(userID: userID);
      if (user?.imagePath == "") {
        _userImagePathMap[userID] = defaultImagePath;
      } else {
        _userImagePathMap[userID] = user?.imagePath ?? defaultImagePath;
      }
    }
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
