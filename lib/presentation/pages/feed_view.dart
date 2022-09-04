import 'package:flutter/material.dart';

import '../../injection.dart';
import '../navigation/navigation.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('피드')),
      body: const Text('피드 서비스 준비중'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sl<NavigationService>().pushNamed('/chat-room-post'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
