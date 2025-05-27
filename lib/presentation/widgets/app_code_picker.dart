import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class AppCodePicker extends StatelessWidget {
  final Function(CountryCode code) onChange;
  final dynamic initialSelection;
  final dynamic favorite;
  final bool isShowFlag;

  const AppCodePicker(
      {super.key,
      required this.onChange,
      this.initialSelection,
      this.favorite,
      this.isShowFlag = true});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return CountryCodePicker(
      onChanged: (code) => onChange(code),
      padding: EdgeInsets.zero,
      initialSelection: initialSelection ?? 'KW',
      favorite: favorite ?? const ['KW'],
      showCountryOnly: true,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      showFlag: isShowFlag,
    );
  }
}
