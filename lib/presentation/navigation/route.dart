import 'package:donghaeng/presentation/pages/chat/chat_room_list_view.dart';
import 'package:flutter/material.dart';

import '../pages/chat/chat_room_post_view.dart';
import '../pages/chat/chat_room_view.dart';
import '../pages/home_view.dart';
import '../pages/profile_edit_view.dart';
import '../pages/sign_in_view.dart';
import '../pages/sign_up_view.dart';
import '../pages/sign_up/gender_view.dart';
import '../pages/sign_up/birth_view.dart';

Map<String, WidgetBuilder> routes(context) => {
      '/home': (_) => const HomeView(),
      '/sign-in': (_) => const SignInView(),
      '/sign-up': (_) => const SignUpView(),
      '/sign-up/gender': (_) => const GenderView(),
      '/sign-up/birth': (_) => const BirthView(),
      // '/sign-up/nickname': (_) => const SignUpView(),
      // '/sign-up/profile': (_) => const SignUpView(),
      // '/sign-up/preferred_countries': (_) => const SignUpView(),
      // '/sign-up/preferred_preferences': (_) => const SignUpView(),
      // '/sign-up/mbti': (_) => const SignUpView(),
      '/profile-edit': (_) => const ProfileEditView(),
      '/chat-room': (_) => const ChatRoomView(),
      '/chat-room-post': (_) => const ChatRoomPostView(),
      '/chat-room-list': (_) => const ChatRoomListView(),
    };
