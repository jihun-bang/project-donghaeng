import 'package:donghaeng/presentation/theme/color.dart';
import 'package:donghaeng/presentation/widgets/sign_up_appbar.dart';
import 'package:donghaeng/presentation/widgets/sign_up_main_button.dart';
import 'package:flutter/material.dart';
import '../../../injection.dart';
import '../../navigation/navigation.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({
    Key? key,
  }) : super(key: key);

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  // FIXME: TempData
  List<String> keywordList = ['핫플레이스', '포토스팟', '쇼핑', '카페', '술집', '현지인 맛집', '미술관', '박물관', '자연경관', '호캉스'];
  List<String> selectedKeywords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpAppbar(value: 0.8),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      const Text('동행러님은 \n어떤 여행을 선호하시나요?',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(height: 32),
                      Wrap(children: [
                        ...keywordList.map((keyword) => keywordButton(keyword)).toList()
                      ],),
                    ])),
            SignUpMainButton(
              text: '다음',
              isEnabled: selectedKeywords.isNotEmpty,
              isSkippable: true,
              callback: () =>
                  sl<NavigationService>().pushNamed("/sign-up/mbti"),
            )
          ],
        ));
  }

  // TODO: FIXME: 서버에서 키워드를 가져온다면 어떤 형태일지에 따라 변경 필요
  Widget keywordButton(String keyword) => 
    Container(
      height: 35,
      margin: const EdgeInsets.only(right: 4, bottom: 12),
      child: 
        OutlinedButton(
          onPressed: () {setState(() {
            selectedKeywords.contains(keyword) ? selectedKeywords.remove(keyword) : selectedKeywords.add(keyword);
          });},
          style: OutlinedButton.styleFrom(backgroundColor: selectedKeywords.contains(keyword)
                  ? MyColors.primeOrange
                  : Colors.white,
              side: BorderSide(width: 1.5, color: selectedKeywords.contains(keyword)
                  ? Colors.transparent
                  : MyColors.systemGrey_300),
              shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))                    
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(keyword,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  color: selectedKeywords.contains(keyword)
                      ? Colors.white
                      : MyColors.systemBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
              ),
            ],
          ),
        ),

    );
    
}
