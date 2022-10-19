import 'package:flutter/material.dart';

class GiGiSliverAppBar extends StatelessWidget {
  final bool floating;
  final bool snap;
  final bool pinned;
  final bool automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final double elevation;
  final Widget? title;
  final double? expandedHeight;
  final Widget? leading;
  final List<Widget>? actions;

  const GiGiSliverAppBar({
    super.key,
    this.floating = false,
    this.snap = false,
    this.pinned = true,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.elevation = 0,
    this.title,
    this.expandedHeight,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: floating,
      snap: snap,
      pinned: pinned,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 1,
      leading: leading,
      actions: actions,
      title: title,
      flexibleSpace: flexibleSpace,
      centerTitle: true,
      expandedHeight: expandedHeight,
    );
  }
}
