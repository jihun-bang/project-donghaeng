import 'package:donghaeng/data/repository/chat_repository_impl.dart';
import 'package:donghaeng/data/repository/chat_room_repository_impl.dart';
import 'package:donghaeng/data/repository/user_repository_impl.dart';
import 'package:donghaeng/domain/repositories/chat_repository.dart';
import 'package:donghaeng/domain/repositories/chat_room_repository.dart';
import 'package:donghaeng/domain/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'presentation/navigation/navigation.dart';
import 'presentation/navigation/navigation_impl.dart';
import 'presentation/provider/chat_room_viewmodel.dart';
import 'presentation/provider/sign_in_viewmodel.dart';
import 'presentation/provider/sign_up_viewmodel.dart';
import 'presentation/provider/user_viewmodel.dart';

final sl = GetIt.instance;

void initLocator() {
  /// Navigation
  sl.registerSingleton<NavigationService>(NavigationServiceImpl());

  /// ViewModel
  sl.registerLazySingleton<SignInViewModel>(() => SignInViewModel());
  sl.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  sl.registerLazySingleton<UserViewModel>(() => UserViewModel());
  sl.registerLazySingleton<ChatroomViewModel>(() => ChatroomViewModel());

  /// Repository
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl());
  sl.registerFactory<ChatRepository>(() => ChatRepositoryImpl());
  sl.registerFactory<ChatRoomRepository>(() => ChatRoomRepositoryImpl());
}
