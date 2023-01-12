import 'package:donghaeng/presentation/theme/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:donghaeng/presentation/widgets/country_dropdown.dart';
import 'package:flutter/material.dart';
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
  Country? countryFirstPick;
  Country? countrySecondPick;
  Country? countryThirdPick;
  List<Country> selectedCountries = [];
  int countryCount = 1;
  
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.7),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('동행러님이 가보고 싶은 \n나라는 어디인가요?',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 50),
                      CountryDropdown(
                        selectedCountry: countryFirstPick,
                        callback: (item) => setState(() => countryFirstPick = item),
                      ),
                      if (countryCount > 1) Column(
                        children: [
                          const SizedBox(height: 32),
                          CountryDropdown(
                              selectedCountry: countrySecondPick,
                              alreadySelected: [countryFirstPick],
                              callback: (item) =>
                                setState(() => countrySecondPick = item),
                            ),
                        ],
                      ),
                      if (countryCount > 2) Column(
                        children: [
                          const SizedBox(height: 32),
                          CountryDropdown(
                              selectedCountry: countryThirdPick,
                              alreadySelected: [countryFirstPick, countrySecondPick],
                              callback: (item) =>
                                setState(() => countryThirdPick = item),
                            ),
                        ],
                      ),
                      Visibility(
                        visible: (countryFirstPick != null && countryCount != 3),
                        child: Column(children: [
                          const SizedBox(height: 24),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 42,
                            child: OutlinedButton(
                              onPressed: () => setState(() => countryCount++),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: MyColors.grey_200,
                                side: const BorderSide(color: Colors.transparent),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                              ),
                              child: SvgPicture.asset('assets/icons/icon_add.svg'),
                          ))
                        ],
                      )),
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: countryFirstPick != null,
              isSkippable: true,
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/preferred_preferences"),
            )
          ],
        ));
  }

}