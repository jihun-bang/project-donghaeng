import 'dart:developer';

import 'package:donghaeng/injection.dart';
import 'package:donghaeng/presentation/navigation/navigation.dart';
import 'package:donghaeng/presentation/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_list_view.dart';
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar,
      body: _body.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _floatingActionButton,
    );
  }

  PreferredSizeWidget get _buildAppBar {
    final menu = IconButton(
      icon: const Icon(Icons.menu_rounded, color: Colors.white),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {},
    );
    final search = IconButton(
      icon: const Icon(CupertinoIcons.search, color: Colors.white),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {},
    );
    final message = IconButton(
      icon: const Icon(Icons.mail_outline_rounded, color: Colors.white),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {sl<NavigationService>().pushNamed('/chat-room-list')},
    );

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: menu,
      actions: [search, message],
    );
  }

  List<Widget> get _body => [
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

  Widget get _floatingActionButton => Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () => sl<NavigationService>().pushNamed('/chat-room-post'),
          tooltip: "new chat room",
          child: const Icon(Icons.add),
        ),
      );
}
