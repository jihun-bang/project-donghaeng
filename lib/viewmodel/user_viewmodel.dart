import 'package:donghaeng/model/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../data/di/locator.dart';
import '../data/repository/user_repository.dart';

class UserViewModel with ChangeNotifier {
  final _repository = sl<UserRepository>();

  u.User? _user;
  u.User? get user => _user;

  final List<User> users = [];

  UserViewModel();

  Future<u.User?> getUser() async {
    _user = await _repository.getUser();
    notifyListeners();
    return user;
  }

  Future<bool> addUser(String id) async {
    return await _repository.addUser(user: u.User(id: id));
  }

  Future<bool> updateUser(u.User user) async {
    return await _repository.updateUser(user: user);
  }

  void logout() {
    _repository.logOut();
  }
}
