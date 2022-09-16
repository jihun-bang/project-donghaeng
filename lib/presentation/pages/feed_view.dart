import 'package:flutter/material.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('피드 서비스 준비중')),
    );
  }
}
