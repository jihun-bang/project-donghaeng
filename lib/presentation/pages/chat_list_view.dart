import 'package:donghaeng/domain/resource/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/toast.dart';
import '../provider/chat_room_viewmodel.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with TickerProviderStateMixin {
  final currentUser = FirebaseAuth.instance.currentUser;

  late TabController _tabController;
  final List<String> _tabList = ['전체보기'];

  int _selectedTabIndex = 0;

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 114),
            child: TabBar(
                onTap: (index) => _onTabTapped(index),
                controller: _tabController,
                isScrollable: true,
                padding: EdgeInsets.zero,
                tabs: _tabList.map((e) => Tab(text: e)).toList()),
          ),
          Expanded(
            child: _communities(context),
          ),
        ],
      );

  Widget _communities(BuildContext context) {
    return Consumer<ChatRoomViewModel>(builder: (_, viewModel, ___) {
      final country = _tabList.elementAt(_selectedTabIndex);
      final chatRooms = viewModel.chatRooms?.values.where((element) =>
          country == _tabList[0] ? true : element.country == country);

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 81),
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
            padding: const EdgeInsets.only(top: 24),
            itemCount: chatRooms!.length,
            itemBuilder: (_, index) {
              final key = viewModel.chatRooms?.keys.elementAt(index);
              final chatRoom = chatRooms.elementAt(index);
              final tags = chatRoom.tags?.map((e) => '#$e').toList().join('');
              return Card(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      if (key == null)
                        {showToast(message: "Error: No chat_room information")}
                      else
                        {viewModel.joinChatRoom(key, chatRoom)}
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          '${_selectedTabIndex != 0 ? '[$country] ' : ''}${chatRoom.title}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          width: 78,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                CupertinoIcons.person,
                                size: 14,
                              ),
                              Text(
                                '+${chatRoom.members.length}명',
                                style: _cardSmallTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${chatRoom.travelDateStart} - ${chatRoom.travelDateEnd}',
                                  style: _cardSmallTextStyle.copyWith(
                                      fontSize: 12)),
                              Text(
                                '$tags\n$tags\n$tags',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 78,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color(0xFFFF8D3A),
                                size: 6,
                              ),
                              Text(
                                '실시간 대화 중',
                                style: _cardSmallTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
