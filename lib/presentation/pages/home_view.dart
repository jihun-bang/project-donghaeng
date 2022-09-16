import 'dart:developer';

import 'package:donghaeng/injection.dart';
import 'package:donghaeng/presentation/navigation/navigation.dart';
import 'package:donghaeng/presentation/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';
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
      appBar: _appbar,
      body: _body.elementAt(_selectedIndex),
      bottomNavigationBar: _bottomNavigationBar,
      floatingActionButton: _floatingActionButton,
    );
  }

  PreferredSizeWidget get _appbar {
    final _menu = IconButton(
      icon: Icon(Icons.menu_rounded, color: MyColors.subPrimary),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {},
    );
    final _search = IconButton(
      icon: Icon(CupertinoIcons.search, color: MyColors.subPrimary),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {},
    );
    final _message = IconButton(
      icon: Icon(Icons.mail_outline_rounded, color: MyColors.subPrimary),
      iconSize: 28,
      padding: EdgeInsets.zero,
      onPressed: () => {sl<NavigationService>().pushNamed('/chat-room-list')},
    );

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: _menu,
      actions: [_search, _message],
    );
  }

  List<Widget> get _body => [
        const ChatListView(),
        const MapView(),
        const FeedView(),
        const ProfileView(),
      ];

  Widget get _bottomNavigationBar => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x54000000),
                  spreadRadius: 4,
                  blurRadius: 20,
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              unselectedItemColor: MyColors.subPrimary,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.place), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_to_photos_rounded), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
              ],
            ),
          ),
        ],
      );

  // todo: 이거 화면에 안뜸..
  Widget get _floatingActionButton => FloatingActionButton(
        onPressed: () => sl<NavigationService>().pushNamed('/chat-room-post'),
        tooltip: "create chat room",
        child: const Icon(Icons.add),
      );
}
