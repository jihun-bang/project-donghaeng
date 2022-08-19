import 'package:donghaeng/viewmodel/user_viewmodel.dart';

import '../data/di/locator.dart';
import '../view/navigation/navigation.dart';

class SignUpViewModel extends UserViewModel {
  String id = '';

  bool _loading = false;
  bool get loading => _loading;

  SignUpViewModel();

  @override
  Future<bool> addUser(String id) async {
    _loading = true;
    notifyListeners();
    if (validateId(id) == null && await super.addUser(id)) {
      _loading = false;
      sl<NavigationService>().pushNamedAndRemoveAll('/home');
    }
    _loading = false;
    notifyListeners();
    return true;
  }

  void setId(String id) {
    this.id = id;
    _loading = true;
    print('$loading $id');
    notifyListeners();
  }

  String? validateId(String? id) {
    if (!RegExp(r'^[0-9a-z_]+$').hasMatch(id ?? '')) {
      return '영문 소문자, 숫자, 언더바만 입력 가능합니다.';
    }
    return null;
  }
}
