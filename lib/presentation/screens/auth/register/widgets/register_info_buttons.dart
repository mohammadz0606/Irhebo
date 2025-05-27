import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/domain/entities/gender_entity.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/widgets/dropdown_item.dart';
import 'package:irhebo/presentation/widgets/dropdown_widget.dart';
import 'package:irhebo/presentation/widgets/multi_dropdown_widget.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class RegisterInfoButtons extends StatelessWidget {
  final String languagesHint;
  final List<DataModel> countries;
  final List<DataModel> languages;
  final List<ProfessionModel> professions;
  final List<GenderEntity> genders;
  final Function(GenderEntity?) onChangedGender;
  final Function(ProfessionModel?) onChangedProfession;
  final Function(DataModel?) onChangedCountry;
  final void Function(List<DataModel?>) onConfirmLanguages;
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
            label: item.name ?? "",
          ),
          label: "Gender",
          showSearchBox: false,
          hintText: "Select Gender",
          items: genders,
          onChanged: onChangedGender,
          validator: AppValidators.validateGender,
          itemToString: (value) => value!.name.toString(),
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        MultiCustomDropdown<DataModel>(
          items: languages
              .map((language) =>
                  MultiSelectItem<DataModel>(language, language.title ?? ""))
              .toList(),
          buttonText: languagesHint,
          label: "Languages",
          onConfirm: (values) {
            onConfirmLanguages(values);
          },
          validators: AppValidators.languagesValidator,
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        CustomDropdown<ProfessionModel>(
          itemBuilder: (context, item, isDisabled, isSelected) => DropdownItem(
            label: item.title ?? "",
          ),
          label: "Profession",
          hintText: "Select Profession",
          items: professions,
          onChanged: onChangedProfession,
          validator: AppValidators.validateProfession,
          itemToString: (value) => value!.title.toString(),
        ),
        SizedBox(
          height: 2.98 * (w / 100),
        ),
        CustomDropdown<DataModel>(
          itemBuilder: (context, item, isDisabled, isSelected) => DropdownItem(
            label: item.title ?? "",
          ),
          showSearchBox: false,
          label: "Country",
          hintText: "Select country",
          items: countries,
          onChanged: onChangedCountry,
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
