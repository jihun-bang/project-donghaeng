import 'package:donghaeng/presentation/provider/user_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/models/user.dart';
import '../../injection.dart';
import '../navigation/navigation.dart';

class SignUpViewModel extends UserViewModel {
  final _userViewModel = sl<UserViewModel>();

  bool _loading = false;
  bool get loading => _loading;

  String id = '';
  String? name;
  String? description;
  String? instagram;

  XFile? _profileImage;
  XFile? get profileImage => _profileImage;

  SignUpViewModel();

  void getProfileImage() {
    ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 500, maxHeight: 500)
        .then((image) {
      if (image != null) {
        _profileImage = image;
        notifyListeners();
      }
    });
  }

  @override
  Future<bool> updateUser({User? user}) async {
    _loading = true;
    notifyListeners();

    final user = _userViewModel.user;
    if (user != null) {
      String imagePath = _profileImage != null
          ? await repository.updateProfileImage(image: _profileImage!) ?? ''
          : user.imagePath;
      final updateUser = User(
          id: user.id,
          name: name ?? user.name,
          imagePath: imagePath,
          description: description ?? user.description,
          instagram: instagram ?? user.instagram);

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
