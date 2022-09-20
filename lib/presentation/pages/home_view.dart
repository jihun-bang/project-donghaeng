import 'dart:developer';

import 'package:donghaeng/injection.dart';
import 'package:donghaeng/presentation/navigation/navigation.dart';
import 'package:donghaeng/presentation/pages/profile_view.dart';
import 'package:donghaeng/presentation/provider/user_viewmodel.dart';
import 'package:donghaeng/presentation/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat/chat_list_view.dart';
import 'feed_view.dart';
import 'map_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('build home view');

    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar,
      drawer: _buildDrawer,
      body: _buildBody.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton,
    );
  }

  PreferredSizeWidget get _buildAppBar {
    final search = IconButton(
      icon: const Icon(CupertinoIcons.search),
      padding: EdgeInsets.zero,
      onPressed: () => {},
    );
    final message = IconButton(
      icon: const Icon(Icons.mail_outline_rounded),
      padding: EdgeInsets.zero,
      onPressed: () => {sl<NavigationService>().pushNamed('/chat-room-list')},
    );

    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/icons/icon_logo.png',
        width: 70,
      ),
      actions: [search, message],
    );
  }

  Drawer get _buildDrawer => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: ProfileImage(
                  size: 49.5, url: sl<UserViewModel>().user?.imagePath),
              title: Text(sl<UserViewModel>().user?.name ?? ''),
              subtitle: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
            ),
            ListTile(
              title: const Text('공지사항'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('계정관리'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('고객센터'),
              onTap: () {},
            ),
            ListTile(
              subtitle: const Text('로그아웃'),
              onTap: () => sl<UserViewModel>().logout(),
            ),
          ],
        ),
      );

  List<Widget> get _buildBody => [
        const ChatListView(),
        const MapView(),
        const FeedView(),
        const ProfileView(),
      ];

  Widget get _buildBottomNavigationBar => BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
      );

  Widget get _buildFloatingActionButton => Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () => sl<NavigationService>().pushNamed('/chat-room-post'),
          tooltip: "new chat room",
          backgroundColor: const Color(0xFFFE7FA8),
          child: const Icon(Icons.add),
        ),
      );
}
