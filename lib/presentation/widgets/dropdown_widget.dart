import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

// ignore: must_be_immutable
class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? Function(T? value)? validator;
  final String Function(T?)? itemToString;
  final String? label;
  final Widget? addIcon;
  final FocusNode? focusNode;
  Widget Function(BuildContext, T, bool, bool) itemBuilder;
  final String? hintText;
  final String? iconPath;
  final Widget? leading;
  final IconData? icon;
  final Color? color;
  final bool showSearchBox;
  final bool hasClearButton;
  final VoidCallback? onClear;
  final Key? clearButtonKey;
  final Color borderColor;
  final String? iconLabel;

  // final String? label;
  final bool isRequired;
  final bool enabled;

  TextEditingController controller = TextEditingController();

  CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.itemToString,
    this.label,
    this.iconPath,
    this.value,
    this.leading,
    this.color,
    this.hasClearButton = false,
    this.onClear,
    this.clearButtonKey,
    this.borderColor = Colors.transparent,
    this.hintText,
    this.addIcon,
    required this.itemBuilder,
    this.focusNode,
    this.validator,
    this.iconLabel,
    this.isRequired = false,
    this.icon,
    this.showSearchBox = true,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...[
          Text(
            label?.tr ?? "",
            style: Get.theme.textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: DropdownSearch<T>(
            enabled: enabled,
            suffixProps: DropdownSuffixProps(
              dropdownButtonProps: DropdownButtonProps(
                  splashRadius: 14,
                  iconClosed: AppIcon(
                    path: AppIcons.arrowbottom,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                  ),
                  iconOpened: AppIcon(
                    path: AppIcons.arrowbottom,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                  ),
                  color: AppDarkColors.pureWhite),
            ),
            selectedItem: value,
            items: (filter, loadProps) => items,
            validator: validator,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            compareFn: (item1, item2) => false,
            popupProps: PopupPropsMultiSelection<T>.menu(
              itemBuilder: (context, item, isDisabled, isSelected) =>
                  itemBuilder(context, item, isDisabled, isSelected),
              fit: FlexFit.loose,
              menuProps: MenuProps(
                backgroundColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkScaffoldColor
                    : AppLightColors.pureWhite,
                barrierColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer.withOpacity(0.3)
                    : AppLightColors.shadow.withOpacity(0.3),
                // borderRadius: BorderRadius.circular(14)
              ),
              searchFieldProps: TextFieldProps(

                  // expands: false,
                  cursorColor: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer.withOpacity(0.5)
                        : AppLightColors.fillTextField,
                    hintStyle: getRegularStyle(
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        fontSize: AppTextStyle.size14),
                    enabledBorder: dropDownOutlinedBorder,
                    border: dropDownOutlinedBorder,
                    focusedBorder: dropDownOutlinedBorder,
                    disabledBorder: dropDownOutlinedBorder,
                    errorMaxLines: 1,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 3.48 * (w / 100),
                      horizontal: 4.97 * (w / 100),
                    ),
                  )),
              showSearchBox: showSearchBox,
              // isFilterOnline: true,
            ),
            onChanged: onChanged,
            itemAsString: (T t) => itemToString!.call(t),
            decoratorProps: DropDownDecoratorProps(
              baseStyle: getRegularStyle(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                  fontSize: AppTextStyle.size16),
              expands: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer.withOpacity(0.5)
                    : AppLightColors.fillTextField,
                enabledBorder: dropDownOutlinedBorder,
                border: dropDownOutlinedBorder,
                focusedBorder: dropDownOutlinedBorder,
                disabledBorder: dropDownOutlinedBorder,
                errorMaxLines: 1,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3.48 * (w / 100),
                  horizontal: 4.97 * (w / 100),
                ),
                labelText: null,
                hintStyle: getRegularStyle(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                    fontSize: AppTextStyle.size14),
                hintText: hintText?.tr,
              ),
            ),
          ),
        )
      ],
    );
  }
}
