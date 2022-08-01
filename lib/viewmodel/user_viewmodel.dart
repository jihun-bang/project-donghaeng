import 'dart:convert';

import 'package:donghaeng/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserViewModel extends ChangeNotifier {
  final List<User> users = [];

  UserViewModel() {
    rootBundle.loadString('assets/data/user.json').then((str) {
      final jsonString = json.decode(str) as List;
      for (final user in jsonString) {
        users.add(User.fromJson(user));
        notifyListeners();
      }
    });
  }
}
