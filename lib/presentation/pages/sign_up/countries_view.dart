import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';

class CountriesView extends StatefulWidget {
  const CountriesView({
    Key? key,
  }) : super(key: key);

  @override
  State<CountriesView> createState() => _CountriesViewState();
}

class _CountriesViewState extends State<CountriesView> {
  List<String> selectedCountries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.8),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('동행러님이 가보고 싶은 나라는 어디인가요?.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 50),
                      
                      
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: selectedCountries.isNotEmpty,
              isSkippable: true,
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/birth"),
            )
          ],
        ));
  }

}