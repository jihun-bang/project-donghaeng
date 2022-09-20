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
            padding: const EdgeInsets.only(left: 15),
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
        padding: const EdgeInsets.only(bottom: 81),
        margin: const EdgeInsets.symmetric(horizontal: 17),
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 18),
            padding: const EdgeInsets.only(top: 56),
            itemCount: chatRooms!.length,
            itemBuilder: (_, index) {
              final key = viewModel.chatRooms?.keys.elementAt(index);
              final chatRoom = chatRooms.elementAt(index);
              final tags = chatRoom.tags?.map((e) => '#$e').toList().join('');
              return InkWell(
                onTap: () => {
                  if (key == null)
                    {showToast(message: "Error: No chat_room information")}
                  else
                    {viewModel.joinChatRoom(key, chatRoom)}
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEAEAEA)),
                  ),
                  padding: const EdgeInsets.only(top: 16, left: 14, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const ProfileImage(size: 46),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_selectedTabIndex != 0 ? '[$country] ' : ''}${chatRoom.title}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(0, 1),
                                        child: Icon(
                                          Icons.mail_outline_rounded,
                                          color: Colors.black.withOpacity(0.4),
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '실시간 대화',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark,
                                size: 24,
                                color: Colors.black.withOpacity(0.3),
                              )),
                        ],
                      ),
                      const Divider(color: Color(0xFFEAEAEA)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${chatRoom.travelDateStart.substring(5, 10).replaceAll('-', '/')}'
                              ' - ${chatRoom.travelDateEnd.substring(5, 10).replaceAll('-', '/')}',
                              style: _cardSmallTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.9))),
                          const SizedBox(height: 8),
                          Text(
                            '$tags\n$tags\n$tags',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}
