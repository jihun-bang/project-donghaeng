import 'package:donghaeng/view/theme/color.dart';
import 'package:donghaeng/view/widget/profile_image.dart';
import 'package:donghaeng/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/di/locator.dart';
import '../model/user.dart' as u;
import 'navigation/navigation.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late u.User user;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (_, viewModel, __) {
      if (viewModel.user != null) {
        user = viewModel.user!;
        return Container(
            alignment: Alignment.topLeft,
            color: MyColors.grey_2,
            child: Column(
              children: [const SizedBox(height: 123), _profile, _badge, _feed],
            ));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget get _profile => Stack(children: [
        _info,
        _image,
      ]);

  Widget get _image => Container(
      margin: const EdgeInsets.only(left: 33),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      padding: const EdgeInsets.all(4),
      child: ProfileImage(url: user.imagePath, size: 95));

  Widget get _info {
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            MaterialButton(
              padding: EdgeInsets.zero,
              minWidth: 24,
              onPressed: () =>
                  sl<NavigationService>().pushNamed('/profile-edit'),
              shape: const CircleBorder(),
              child: const Icon(Icons.settings),
            )
          ],
        ),
        Text(
          user.description,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7)),
        ),
      ],
    );

    Widget bodyItem(IconData icon, String text) => SizedBox(
          height: 22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black.withOpacity(0.54),
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1, left: 8),
                child: Text(text, style: TextStyle(color: MyColors.grey_3)),
              ),
            ],
          ),
        );

    final body = Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bodyItem(CupertinoIcons.location_solid, '위치'),
          bodyItem(Icons.link_rounded, user.instagram),
          bodyItem(Icons.mail_outline_rounded, 'N분전 활동'),
        ],
      ),
    );

    Widget bottomItem(String count, String text) => Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF121212)),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6A6A6A),
              ),
            ),
          ],
        );

    final line = Container(
      width: 2,
      height: 38,
      margin: const EdgeInsets.only(left: 30, right: 30),
      color: MyColors.grey_200,
    );

    final bottom = SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bottomItem('12', '방문국가'),
            line,
            bottomItem('1.2M', '팔로워'),
            line,
            bottomItem('0', '게시물'),
          ],
        ));

    return Container(
      padding: const EdgeInsets.only(top: 60, left: 36, right: 36, bottom: 32),
      margin: const EdgeInsets.only(top: 47),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Column(
        children: [
          header,
          body,
          bottom,
        ],
      ),
    );
  }

  Widget get _badge => SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 20),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (_, __) => const SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
        ),
      );

  Widget get _feed => Expanded(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: GridView.builder(
              padding: const EdgeInsets.all(35),
              itemCount: 50,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (_, __) => Container(
                constraints:
                    const BoxConstraints(minWidth: 100, minHeight: 100),
                decoration: BoxDecoration(
                    color: MyColors.grey_2,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )),
      );
}
