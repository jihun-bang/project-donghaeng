import 'package:cached_network_image/cached_network_image.dart';
import 'package:donghaeng/presentation/widgets/gigi_sliver_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/user.dart' as u;
import '../../injection.dart';
import '../navigation/navigation.dart';
import '../provider/user_viewmodel.dart';
import '../theme/color.dart';
import '../widgets/profile_image.dart';

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
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_header, _body];
          },
          body: _feed,
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  final _profileSetting = Padding(
    padding: const EdgeInsets.only(right: 15),
    child: IconButton(
      icon: const Icon(Icons.settings),
      padding: EdgeInsets.zero,
      onPressed: () => sl<NavigationService>().pushNamed('/profile-edit'),
    ),
  );

  Widget get _header => GiGiSliverAppBar(
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: user.backgroundImagePath.isNotEmpty
                ? BoxDecoration(
                    color: MyColors.primary,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            user.backgroundImagePath),
                        fit: BoxFit.cover))
                : null,
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _image,
              _info,
            ]),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height / 2.5,
        actions: [_profileSetting],
      );

  Widget get _image => ProfileImage(url: user.imagePath, size: 95);

  Widget get _info => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            user.name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            user.description,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      );

  Widget get _body {
    final line = Container(
      width: 2,
      height: 38,
      margin: const EdgeInsets.only(left: 30, right: 30),
      color: MyColors.grey_200,
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

    Widget topItem(IconData icon, String text) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: MyColors.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1, left: 5),
              child: Text(text, style: TextStyle(color: MyColors.grey_3)),
            ),
          ],
        );

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  topItem(CupertinoIcons.location_solid, '위치'),
                  const SizedBox(width: 41),
                  topItem(Icons.link_rounded, user.instagram),
                  const SizedBox(width: 41),
                  topItem(Icons.mail_outline_rounded, 'N분전 활동'),
                ],
              )),
          SizedBox(
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
              )),
        ],
      ),
    );
  }

  Widget get _feed => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: 50,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, mainAxisSpacing: 8, crossAxisSpacing: 12),
        itemBuilder: (_, __) => Container(
          constraints: const BoxConstraints(minWidth: 122, minHeight: 122),
          color: MyColors.grey_2,
        ),
      );
}
