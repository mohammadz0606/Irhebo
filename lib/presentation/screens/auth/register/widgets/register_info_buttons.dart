import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/widgets/dropdown_item.dart';
import 'package:irhebo/presentation/widgets/dropdown_widget.dart';
import 'package:irhebo/presentation/widgets/multi_dropdown_widget.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../domain/models/new_models/new_config_model.dart';

class RegisterInfoButtons extends StatelessWidget {
  final String languagesHint;
  final List<NewConfigModelDataCountries?> countries;
  final List<NewConfigModelDataLanguagesData?> languages;
  final List<NewConfigModelDataProfessions?> professions;
  final List<GenderEntity> genders;
  final Function(GenderEntity?) onChangedGender;
  final Function(NewConfigModelDataProfessions?) onChangedProfession;
  final Function(NewConfigModelDataCountries?) onChangedCountry;
  final void Function(List<NewConfigModelDataLanguagesData?>)
      onConfirmLanguages;

  //----

  final NewConfigModelDataCountries? initCountry;
  final NewConfigModelDataProfessions? initProfessions;
  final GenderEntity? initGender;
  final List<NewConfigModelDataLanguagesData?>? selectedLanguages;

  const RegisterInfoButtons({
    super.key,
    required this.languagesHint,
    required this.countries,
    required this.languages,
    required this.professions,
    required this.genders,
    required this.onChangedGender,
    required this.onChangedProfession,
    required this.onChangedCountry,
    required this.onConfirmLanguages,
    this.initCountry,
    this.initProfessions,
    this.initGender,
    this.selectedLanguages,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        CustomDropdown<GenderEntity>(
          itemBuilder: (context, item, isDisabled, isSelected) => DropdownItem(
            label: Get.locale?.languageCode == 'ar'
                ? item.nameAr ?? ''
                : item.name ?? "",
          ),
          label: "Gender",
          showSearchBox: false,
          hintText: "Select Gender",
          items: genders,
          value: initGender,
          onChanged: onChangedGender,
          validator: AppValidators.validateGender,
          itemToString: (value) {
            if (Get.locale?.languageCode == 'ar') {
              return value!.nameAr.toString();
            } else {
              return value!.name.toString();
            }
          },
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        MultiCustomDropdown<NewConfigModelDataLanguagesData?>(
          items: languages
              .map((language) =>
                  MultiSelectItem<NewConfigModelDataLanguagesData?>(
                      language, language?.title ?? ""))
              .toList(),
          buttonText: languagesHint,
          label: "Languages",
          initialValue: selectedLanguages,
          showSelected: selectedLanguages?.isNotEmpty == true,
          onConfirm: (values) {
            onConfirmLanguages(values);
          },
          validators: AppValidators.languagesValidator,
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        CustomDropdown<NewConfigModelDataProfessions?>(
          itemBuilder: (context, item, isDisabled, isSelected) => DropdownItem(
            label: item?.title ?? "",
          ),
          label: "Profession",
          hintText: "Select Profession",
          items: professions,
          value: initProfessions,
          onChanged: onChangedProfession,
          validator: AppValidators.validateProfession,
          itemToString: (value) => value!.title.toString(),
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        CustomDropdown<NewConfigModelDataCountries?>(
          itemBuilder: (context, item, isDisabled, isSelected) => DropdownItem(
            label: item?.title ?? "",
          ),
          showSearchBox: true,
          label: "Country",
          hintText: "Select Country",
          items: countries,
          onChanged: onChangedCountry,
          value: initCountry,
          validator: AppValidators.validateCountry,
          itemToString: (value) => value!.title.toString(),
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
      ],
    );
  }
}
