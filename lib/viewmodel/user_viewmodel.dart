import 'package:dongheang/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  final userNames = ['구반석', '박정아', '박진양', '방지호', '방지훈', '태성현'];
  final List<User> users = [];

  UserViewModel() {
    users.addAll(userNames.asMap().entries.map((e) {
      return User(e.key, e.value, 'assets/images/${e.value}.PNG');
    }));
    notifyListeners();
  }
}
