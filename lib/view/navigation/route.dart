import 'package:donghaeng/view/chat_room_post_view.dart';
import 'package:donghaeng/view/chat_room_view.dart';
import 'package:donghaeng/view/home_view.dart';
import 'package:donghaeng/view/profile_edit_view.dart';
import 'package:donghaeng/view/sign_in_view.dart';
import 'package:donghaeng/view/sign_up_view.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes(context) => {
      '/home': (_) => const HomeView(),
      '/sign-in': (_) => const SignInView(),
      '/sign-up': (_) => const SignUpView(),
      '/profile-edit': (_) => const ProfileEditView(),
      '/chat-room': (_) => const ChatRoomView(),
      '/chat-room-post': (_) => const ChatRoomPostView(),
    };
