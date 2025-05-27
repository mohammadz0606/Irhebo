import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

// ignore: must_be_immutable
class MultiCustomDropdown<T> extends StatelessWidget {
  final List<MultiSelectItem<T?>> items;
  final String? label;
  final String buttonText;
  final String? Function(List<T?>?)? validators;
  final void Function(List<T?>) onConfirm;

  const MultiCustomDropdown({
    super.key,
    required this.items,
    this.label,
    required this.buttonText,
    this.validators,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        MultiSelectBottomSheetField<T?>(
          initialChildSize: 0.5,
          backgroundColor: Get.find<AppController>().darkMode
              ? AppDarkColors.darkScaffoldColor
              : Colors.white,
          barrierColor: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer.withOpacity(0.3)
              : AppLightColors.shadow.withOpacity(0.3),
          selectedItemsTextStyle: getRegularStyle(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
              fontSize: AppTextStyle.size14),
          title: Text(
            label?.tr ?? "",
            style: Get.theme.textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          buttonText: Text(
            buttonText,
            style: getRegularStyle(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
                fontSize: AppTextStyle.size14),
          ),
          items: items,
          chipDisplay: MultiSelectChipDisplay.none(),
          itemsTextStyle: getRegularStyle(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
              fontSize: AppTextStyle.size14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          searchable: true,
          validator: validators,
          onConfirm: onConfirm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
