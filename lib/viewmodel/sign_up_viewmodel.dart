import 'package:donghaeng/viewmodel/user_viewmodel.dart';

import '../data/di/locator.dart';
import '../model/user.dart';
import '../view/navigation/navigation.dart';

class SignUpViewModel extends UserViewModel {
  final _userViewModel = sl<UserViewModel>();

  String id = '';
  String name = '';
  String description = '';
  String instagram = '';

  bool _loading = false;

  bool get loading => _loading;

  SignUpViewModel();

  @override
  Future<bool> updateUser({User? user}) async {
    _loading = true;
    notifyListeners();

    final user = _userViewModel.user;
    if (user != null) {
      final updateUser = User(
          id: user.id,
          name: name,
          description: description,
          instagram: instagram);

      if (await super.updateUser(user: updateUser)) {
        sl<NavigationService>().pushNamedAndRemoveAll('/home');
      }
    }

    _loading = false;
    notifyListeners();
    return true;
  }

  String? validateId(String? id) {
    if (!RegExp(r'^[0-9a-z_]+$').hasMatch(id ?? '')) {
      return '영문 소문자, 숫자, 언더바만 입력 가능합니다.';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name?.isEmpty == true) {
      return '필수 입력 항목입니다.';
    }
    return null;
  }
}
