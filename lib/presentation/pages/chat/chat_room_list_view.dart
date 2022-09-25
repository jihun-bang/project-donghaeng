import 'dart:developer';

import 'package:donghaeng/injection.dart';
import 'package:donghaeng/presentation/navigation/navigation.dart';
import 'package:donghaeng/presentation/provider/chat_room_viewmodel.dart';
import 'package:donghaeng/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({Key? key}) : super(key: key);

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  final _chatRoomViewModel = sl<ChatRoomViewModel>();

  @override
  Widget build(BuildContext context) {
    log('build chat_room_list_view');
    return _view;
  }

  Widget get _view => Scaffold(
        appBar: _appBar,
        body: _body,
      );

  PreferredSizeWidget get _appBar => AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(child: Center(child: Text('메세지'))),
              ],
            ),
          ),
        ),
      );

  Widget get _body => Consumer<ChatRoomViewModel>(builder: (_, __, ___) {
        log('build chat_room_list_view_body');
        return (_chatRoomViewModel.myChatRooms.isEmpty)
            ? _noChatRoom
            : _chatRoomList;
      });

  Widget get _noChatRoom => const Center(child: Text('채팅방 목록이 존재하지 않습니다.'));

  Widget get _chatRoomList => ListView.builder(
      itemCount: _chatRoomViewModel.myChatRooms.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final chatRoomMap =
            _chatRoomViewModel.myChatRooms.entries.elementAt(index);
        final chatRoomID = chatRoomMap.key;
        final chatRoom = chatRoomMap.value;

        return InkWell(
          onTap: () => sl<NavigationService>()
              .pushNamed("/chat-room", arguments: {'chatRoomID': chatRoomID}),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ProfileImage(size: 46),
                const SizedBox(width: 10),
                Text(chatRoom.title)
              ],
            ),
          ),
        );
      });
}
