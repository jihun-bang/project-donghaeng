import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/di/locator.dart';
import '../data/repository/user_repository.dart';
import '../model/user.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _repository = sl<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _repository.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.id),
                  Text(user.description),
                  Text(user.instagram),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
