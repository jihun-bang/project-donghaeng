import 'package:donghaeng/data/repository/chat_room_repository.dart';
import 'package:donghaeng/data/repository/chatroom_repository.dart';
import 'package:donghaeng/data/repository/impl/chat_room_repository_impl.dart';
import 'package:donghaeng/data/repository/impl/chatroom_repository_impl.dart';
import 'package:donghaeng/viewmodel/chat_room_viewmodel.dart';
import 'package:get_it/get_it.dart';

import '../../view/navigation/navigation.dart';
import '../../view/navigation/navigation_impl.dart';
import '../../viewmodel/sign_in_viewmodel.dart';
import '../../viewmodel/sign_up_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../repository/impl/user_repository_impl.dart';
import '../repository/user_repository.dart';

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
