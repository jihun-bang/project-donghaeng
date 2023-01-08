import 'package:donghaeng/presentation/pages/chat/chat_room_list_view.dart';
import 'package:donghaeng/presentation/pages/sign_up/mbti_view.dart';
import 'package:donghaeng/presentation/pages/sign_up/nickname_view.dart';
import 'package:donghaeng/presentation/pages/sign_up/preferences_view.dart';
import 'package:donghaeng/presentation/pages/sign_up/profile_view.dart';
import 'package:flutter/material.dart';
import '../pages/chat/chat_room_post_view.dart';
import '../pages/chat/chat_room_view.dart';
import '../pages/home_view.dart';
import '../pages/profile_edit_view.dart';
import '../pages/sign_in_view.dart';
import '../pages/sign_up_view.dart';
import '../pages/sign_up/gender_view.dart';
import '../pages/sign_up/birth_view.dart';
import '../pages/sign_up/countries_view.dart';

Map<String, WidgetBuilder> routes(context) => {
      '/home': (_) => const HomeView(),
      '/sign-in': (_) => const SignInView(),
      // Sign Up views
      '/sign-up': (_) => const SignUpView(),
      '/sign-up/gender': (_) => const GenderView(),
      '/sign-up/birth': (_) => const BirthView(),
      '/sign-up/nickname': (_) => const NicknameView(),
      '/sign-up/profile': (_) => const ProfileSetupView(),
      '/sign-up/preferred_countries': (_) => const CountriesView(),
      '/sign-up/preferred_preferences': (_) => const PreferencesView(),
      '/sign-up/mbti': (_) => const MBTIView(),
      //
      '/profile-edit': (_) => const ProfileEditView(),
      '/chat-room': (_) => const ChatRoomView(),
      '/chat-room-post': (_) => const ChatRoomPostView(),
      '/chat-room-list': (_) => const ChatRoomListView(),
    };
