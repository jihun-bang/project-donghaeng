import 'package:donghaeng/domain/resource/country.dart';
import 'package:donghaeng/presentation/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/toast.dart';
import '../../provider/chat_room_viewmodel.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with TickerProviderStateMixin {
  final currentUser = FirebaseAuth.instance.currentUser;

  late TabController _tabController;
  final List<String> _tabList = [];

  int _selectedTabIndex = 0;
  String _selectedCountry = "";

  final _cardSmallTextStyle =
      const TextStyle(fontSize: 8, color: Color(0xFF646464));

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    for (var element in Country.values) {
      _tabList.add(element.korean);
    }
    _selectedCountry = _tabList.first;
    _tabController = TabController(length: Country.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _countryDropdown(context),
              Row(
                children: const <Widget>[
                  Icon(
                    Icons.add_box_outlined,
                    size: 30,
                  ),
                  Icon(
                    Icons.notifications_none,
                    size: 30,
                  )
                ],
              )
            ],
          ),
          // TabBar(
          //     onTap: (index) => _onTabTapped(index),
          //     controller: _tabController,
          //     isScrollable: true,
          //     padding: EdgeInsets.zero,
          //     indicatorSize: TabBarIndicatorSize.label,
          //     tabs: _tabList.map((e) => Tab(text: e)).toList()),
          Expanded(
            child: _communities(context),
          ),
        ],
      );

  Widget _countryDropdown(BuildContext context) {
      return DropdownButton<String>(
      value: _selectedCountry,
      underline: Container(color: Colors.transparent),
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.black,
        size: 24,
      ),
      elevation: 16,
      style: const TextStyle(fontSize: 30),
      onChanged: (String? value) {
        setState(() {
          _selectedCountry = value!;
        });
      },
      items: _tabList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _communities(BuildContext context) {
    return Consumer<ChatRoomViewModel>(builder: (_, viewModel, ___) {
      final country = _tabList.elementAt(_selectedTabIndex);
      final chatRooms = viewModel.publicChatRooms.values.where((element) =>
          country == _tabList[0] ? true : element.country == country);

      return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 18),
          padding: const EdgeInsets.all(17),
          itemCount: chatRooms.length,
          itemBuilder: (_, index) {
            final chatRoomID = viewModel.publicChatRooms.keys.elementAt(index);
            final chatRoom = chatRooms.elementAt(index);
            final latestChat =
                DateTime.now().difference(chatRoom.latestChatAt).inMinutes;
            final startDate =
                chatRoom.travelDateStart.substring(5, 10).replaceAll('-', '.');
            final endDate =
                chatRoom.travelDateEnd.substring(5, 10).replaceAll('-', '.');

            return InkWell(
              onTap: () => viewModel.joinChatRoom(chatRoomID),
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Image.asset(
                    'images/croatia_example.png',
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('지역이름, $country\n$startDate - $endDate',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30)),
                          Text(chatRoom.title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // todo; image
                              Text(
                                '${chatRoom.members.length}명 참여중',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '$latestChat분 전 대화',
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
