import 'package:flutter/material.dart';

import '../pages/chat_room_post_view.dart';
import '../pages/chat_room_view.dart';
import '../pages/home_view.dart';
import '../pages/profile_edit_view.dart';
import '../pages/sign_in_view.dart';
import '../pages/sign_up_view.dart';

Map<String, WidgetBuilder> routes(context) => {
      '/home': (_) => const HomeView(),
      '/sign-in': (_) => const SignInView(),
      '/sign-up': (_) => const SignUpView(),
      '/profile-edit': (_) => const ProfileEditView(),
      '/chat-room': (_) => const ChatRoomView(),
      '/chat-room-post': (_) => const ChatRoomPostView(),
    };
