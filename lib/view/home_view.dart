import 'package:donghaeng/viewmodel/chat_viewmodel.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late UserViewModel userViewModel;
  late ChatViewModel chatViewModel;

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
        onPressed: () => chatViewModel.addChat(),
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
    return Consumer<UserViewModel>(builder: (_, viewModel, ___) {
      userViewModel = viewModel;

      return Container(
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
          ));
    });
  }

  Widget _communities() {
    return Consumer<ChatViewModel>(builder: (_, viewModel, ___) {
      chatViewModel = viewModel;

      return Expanded(
        child: ListView.builder(
            itemCount: viewModel.chats.length,
            itemBuilder: (_, index) {
              final chat = viewModel.chats[index];
              final users = userViewModel.users
                  .where((user) => chat.members.contains(user.id));
              final host = users.first;

              return Card(
                child: ListTile(
                  onTap: () => {},
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(host.imagePath),
                  ),
                  title: Text(chat.title +
                      '\n${users.map((e) => '${e.nickName} 💬').take(4).join('\n')}'),
                  subtitle: Text(chat.tags.map((e) => '#$e').toList().join('')),
                  trailing: Column(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.person,
                              size: 20,
                            ),
                            Text('${chat.members.length}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.chat_bubble_text,
                              size: 20,
                            ),
                            Text('${chat.members.length * 50}'),
                          ],
                        ),
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
