import 'package:donghaeng/viewmodel/chat_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final currentUser = FirebaseAuth.instance.currentUser;

  late TabController _tabController;
  final _tabList = const ['전체보기', '영국', '프라하', '크로아티아'];
  int _selectedTabIndex = 0;

  final _titleTextStyle = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white);
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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/image_home_$_selectedTabIndex.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 98, 32, 24),
              child: Text(
                '${currentUser?.displayName} 님,\n함께할 여행자를 찾으세요?',
                style: _titleTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TabBar(
                  onTap: (index) => _onTabTapped(index),
                  controller: _tabController,
                  labelStyle: _titleTextStyle,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  indicatorColor: Colors.transparent,
                  tabs: _tabList.map((e) => Tab(text: e)).toList()),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
                child: _communities(context),
              ),
            ),
          ],
        ),
      );

  Widget _communities(BuildContext context) {
    return Consumer<ChatViewModel>(builder: (_, viewModel, ___) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 81),
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
            padding: const EdgeInsets.only(top: 24),
            itemCount: viewModel.chats
                .where((element) => element.title.contains(
                    _selectedTabIndex != 0
                        ? _tabList.elementAt(_selectedTabIndex)
                        : ''))
                .length,
            itemBuilder: (_, index) {
              final chat = viewModel.chats[index];
              final users = context
                  .watch<UserViewModel>()
                  .users
                  .where((user) => chat.members.contains(user.id));
              final country = _tabList.elementAt(_selectedTabIndex);
              final tags = chat.tags.map((e) => '#$e').toList().join('');
              return Card(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {},
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          '${_selectedTabIndex != 0 ? '[$country] ' : ''}${chat.title}',
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
                                '+${chat.members.length}명',
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
                                  '${chat.travelDate.start} - ${chat.travelDate.end}',
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
