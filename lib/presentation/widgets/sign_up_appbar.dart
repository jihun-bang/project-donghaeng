import 'package:donghaeng/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
// import 'package:donghaeng/presentation/theme/color.dart';
// import '../../injection.dart';
// import '../navigation/navigation.dart';

class SignUpAppbar extends AppBar implements PreferredSizeWidget {
  final double value;
  SignUpAppbar({Key? key, required this.value}) 
  : super(
      key: key,
      bottom: ProgressBar(value: value)
    );  
}