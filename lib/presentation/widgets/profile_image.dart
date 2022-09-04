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
            borderRadius: BorderRadius.circular(size / 2),
            border: Border.all(color: const Color(0xFF9C9C9C))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: url?.isNotEmpty == true
              ? CachedNetworkImage(
                  imageUrl: url!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : SvgPicture.asset('assets/icons/icon_default_profile.svg'),
        ));
  }
}
