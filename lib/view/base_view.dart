import 'package:donghaeng/view/feed_view.dart';
import 'package:donghaeng/view/home_view.dart';
import 'package:donghaeng/view/map_view.dart';
import 'package:donghaeng/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme/color.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _appbar,
      body: _body.elementAt(_selectedIndex),
      bottomNavigationBar: _bottomNavigationBar,
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
      onPressed: () => {},
    );

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: _menu,
      actions: [_search, _message],
    );
  }

  List<Widget> get _body => [
        const HomeView(),
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
}
