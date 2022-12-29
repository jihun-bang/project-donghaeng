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
  String? phoneNumber;

  

  XFile? _profileImage;
  XFile? get profileImage => _profileImage;

  XFile? _backgroundImage;
  XFile? get backgroundImage => _backgroundImage;

  SignUpViewModel();

  void getProfileImage({bool isProfile = true}) {
    ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 500, maxHeight: 500)
        .then((image) {
      if (image != null) {
        if (isProfile) {
          _profileImage = image;
        } else {
          _backgroundImage = image;
        }
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
          ? await repository.updateProfileImage(
                  image: _profileImage!, isProfile: true) ??
              ''
          : user.imagePath;
      String backgroundImagePath = _backgroundImage != null
          ? await repository.updateProfileImage(
                  image: _backgroundImage!, isProfile: false) ??
              ''
          : user.backgroundImagePath;
      final updateUser = User(
          id: user.id,
          name: name ?? user.name,
          imagePath: imagePath,
          backgroundImagePath: backgroundImagePath,
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
