import 'package:get_it/get_it.dart';

import '../../viewmodel/login_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../repository/impl/user_repository_impl.dart';
import '../repository/user_repository.dart';

final sl = GetIt.instance;

void initLocator() {
  /// ViewModel
  sl.registerFactory<LoginViewModel>(() => LoginViewModel());
  sl.registerFactory<UserViewModel>(() => UserViewModel());

  /// Repository
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl());
}
