import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatelessWidget {
  final String? url;
  final double size;

  const ProfileImage({Key? key, this.url, this.size = 82}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: url?.isNotEmpty == true
                  ? CachedNetworkImageProvider(url!)
                  : null,
              child: url?.isNotEmpty != true
                  ? SvgPicture.asset('assets/icons/icon_default_profile.svg')
                  : null,
            ),
    );
  }
}
