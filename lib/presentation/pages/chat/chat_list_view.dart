import 'package:donghaeng/domain/resource/country.dart';
import 'package:donghaeng/presentation/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          TabBar(
              onTap: (index) => _onTabTapped(index),
              controller: _tabController,
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabList.map((e) => Tab(text: e)).toList()),
          Expanded(
            child: _communities(context),
          ),
        ],
      );

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
            final tags = chatRoom.tags?.map((e) => '#$e').toList().join('');
            final latestChat =
                DateTime.now().difference(chatRoom.latestChatAt).inMinutes;

            return InkWell(
              onTap: () => viewModel.joinChatRoom(chatRoomID),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEAEAEA)),
                ),
                padding: const EdgeInsets.only(
                    top: 16, left: 14, bottom: 18, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '지역이름',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        const Text(',',
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        const SizedBox(width: 6),
                        Text(country,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15)),
                        const SizedBox(width: 6),
                        Text(
                            '${chatRoom.travelDateStart.substring(5, 10).replaceAll('-', '.')}'
                            ' - ${chatRoom.travelDateEnd.substring(5, 10).replaceAll('-', '.')}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_selectedTabIndex != 0 ? '[$country] ' : ''}${chatRoom.title}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const ProfileImage(size: 30),
                            const SizedBox(height: 8),
                            Text(
                              '${chatRoom.members.length}명 참여중',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 1),
                              child: Icon(
                                Icons.mode_comment_rounded,
                                color: Colors.black.withOpacity(0.4),
                                size: 18,
                              ),
                            ),
                            Text(
                              '$latestChat분 전 대화',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
