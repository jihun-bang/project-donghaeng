import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:donghaeng/presentation/theme/color.dart';
import '../../data/constants.dart' as constants;

class CountryDropdown extends StatefulWidget {
  final Country? selectedCountry;
  final List<Country?>? alreadySelected;
  final Function callback;
  const CountryDropdown(
      {Key? key,
      this.selectedCountry,
      this.alreadySelected,
      required this.callback})
      : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: 
          DropdownButton2(
            customButton: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: widget.selectedCountry == null ? MyColors.systemGrey_300 : MyColors.primeOrange, width: 2))
              ),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.selectedCountry == null ?
                  Text('나라 선택하기', style: TextStyle(fontSize: 20, color: MyColors.systemGrey_400, fontWeight: FontWeight.w500)) 
                  : Row(
                    children: [
                      Text(widget.selectedCountry!.name_kr,
                        style: TextStyle(
                          color: MyColors.systemBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        )),
                      const SizedBox(width: 8),
                      Image(
                        image: NetworkImage(
                            '/assets/flags/${widget.selectedCountry!.code.toLowerCase()}.png'),
                      )
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: MyColors.systemSoftBlack),
                      const SizedBox(width: 12)
                    ],
                  )
                ],
              )
            ),
            selectedItemHighlightColor: MyColors.primeOrange_200,
            focusColor: MyColors.primeOrange_200,
            isExpanded: true,
            dropdownMaxHeight: MediaQuery.of(context).size.height / 2.5,
            buttonPadding: const EdgeInsets.only(left: 0, right: 16, bottom: 6),
            hint: Text('나라 선택하기',
                style: TextStyle(
                    fontSize: 20,
                    color: MyColors.systemGrey_400,
                    fontWeight: FontWeight.w500)),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            iconSize: 26,
            value: widget.selectedCountry,
            items: (widget.alreadySelected != null)
                ? CountryList.countryList
                    .where((country) => !widget.alreadySelected!.contains(country))
                    .map((country) => DropdownMenuItem<Country>(
                        value: country, child: CountryList.buildItem(country)))
                    .toList()
                : CountryList.countryList
                    .map((country) => DropdownMenuItem<Country>(
                        value: country, child: CountryList.buildItem(country)))
                    .toList(),
            onChanged: (value) => widget.callback(value),
            searchController: textEditingController,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
              child: TextFormField(
                autofocus: true,
                controller: textEditingController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.selectedCountry != null
                            ? MyColors.primeOrange
                            : MyColors.systemGrey_400,
                        width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primeOrange, width: 2),
                  ),
                  errorBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: MyColors.systemError, width: 2)),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  hintText: '검색',
                  hintStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
            offset: const Offset(0, -10),
            dropdownElevation: 8,
          ),
      ),
    );
  }
}

class Country {
  final String name_en;
  final String dial_code;
  final String code;
  final String name_kr;

  const Country({
    required this.name_en,
    required this.dial_code,
    required this.code,
    required this.name_kr,
  });

  @override
  String toString() {
    return '{name_en: $name_en, dial_code: $dial_code, code: $code, name_kr: $name_kr}';
  }
}

class CountryList {
  static List<Country> countryList = [
    ...constants.countryList
        .map((country) => Country(
              name_en: country["name_en"],
              dial_code: country["dial_code"],
              code: country["code"],
              name_kr: country["name_kr"],
            ))
        .toList()
  ];

  static Widget buildItem(Country item) {
    return Row(children: [
      Text(item.name_kr,
          style: TextStyle(
            color: MyColors.systemBlack,
            fontSize: 20,
          )),
      const SizedBox(width: 8),
      Image(
        image: NetworkImage('/assets/flags/${item.code.toLowerCase()}.png'),
      )
    ]);
  }
}
