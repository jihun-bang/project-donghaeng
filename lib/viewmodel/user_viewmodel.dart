import 'package:donghaeng/model/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../data/di/locator.dart';
import '../data/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final _repository = sl<UserRepository>();

  late User _user;
  User get user => _user;
  set user(user) => _user = user;

  final List<User> users = [];

  UserViewModel();

  Future<bool> validateUser() async {
    return await _repository.getUser() != null;
  }

  Future<bool> addUser(String id) async {
    return await _repository.addUser(user: u.User(id: id));
  }

  Future<void> logout() async {
    await _repository.logOut();
  }
}
