import 'package:flutter/material.dart';
import 'package:donghaeng/presentation/theme/color.dart';

class ProgressBar extends PreferredSize {
  final double value;

  ProgressBar({Key? key, required this.value}) 
  : super(
    key: key,
    child: LinearProgressIndicator(backgroundColor:  MyColors.grey_200, valueColor: AlwaysStoppedAnimation<Color>(MyColors.primeOrange), value: value),
    preferredSize: const Size.fromHeight(4.0),
    );

  @override

  Widget build(BuildContext context) {
    return PreferredSize(preferredSize: const Size.fromHeight(4.0),
    child: LinearProgressIndicator(backgroundColor:  MyColors.grey_200, valueColor: AlwaysStoppedAnimation<Color>(MyColors.primeOrange), value: value)
    );
  }
}