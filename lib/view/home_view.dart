import 'package:dongheang/viewmodel/chat_viewmodel.dart';
import 'package:dongheang/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동행'),
        centerTitle: false,
        actions: [_notification(), _message()],
      ),
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_onlineUsers(), _communities()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: '피드'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: '캘린더'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '설정')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: '방 만들기',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _notification() {
    return IconButton(
        onPressed: () => {}, icon: const Icon(CupertinoIcons.bell));
  }

  Widget _message() {
    return IconButton(onPressed: () => {}, icon: const Icon(Icons.send));
  }

  Widget _onlineUsers() {
    return Consumer<UserViewModel>(
        builder: (_, viewModel, ___) => Container(
            alignment: Alignment.center,
            height: 90,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 8, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.users.length,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => {},
                        customBorder: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage(viewModel.users[index].imagePath),
                        ),
                      ),
                      Text(
                        viewModel.users[index].nickName,
                        style: const TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                );
              },
            )));
  }

  Widget _communities() {
    return Consumer<ChatViewModel>(
        builder: (_, viewModel, ___) => Expanded(
              child: ListView.builder(
                  itemCount: viewModel.chats.length,
                  itemBuilder: (_, index) {
                    final chat = viewModel.chats[index];
                    return Card(
                      child: ListTile(
                        onTap: () => {},
                        title: Text(chat.title),
                        subtitle:
                            Text(chat.tags.map((e) => '#$e').toList().join('')),
                        trailing: Text('${chat.members}/${chat.maxMember}'),
                      ),
                    );
                  }),
            ));
  }
}
