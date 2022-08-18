import 'package:donghaeng/data/repository/impl/user_repository_impl.dart';
import 'package:donghaeng/data/repository/user_repository.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initLocator() {
  /// ViewModel
  sl.registerFactory<UserViewModel>(() => UserViewModel());

  /// Repository
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl());
}
