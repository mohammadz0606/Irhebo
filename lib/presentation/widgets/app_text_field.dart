import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isVisible;
  final bool isPassword;
  final bool isPhone;
  final bool isNumber;
  final bool? readOnly;
  final bool? enabled;
  final bool isSearch;
  final bool isChat;
  final bool isThereError;
  final bool isDate;
  final Color? fillColor;
  final TextInputType? textInputType;
  final String? Function(String?)? onValidate;
  final Function(String)? onSubmit;
  final Function()? onTapOutside;
  final Function(String)? onChange;
  final Function(CountryCode)? onChangeCountryCode;
  final String? label;
  final String? hint;
  final String? initialSelection;
  final Function()? onTap;
  final void Function()? onTapVisible;
  final double? radius;
  final double? width;
  final String? icon;
  final String? error;
  final int? maxLines;
  final Color? borderColor;
  final Color? filledColor;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.isVisible = true,
    this.enabled = true,
    this.readOnly = false,
    this.isThereError = true,
    this.onTap,
    this.maxLines,
    this.hint,
    this.error,
    this.onTapOutside,
    this.onChangeCountryCode,
    this.borderColor = Colors.grey,
    this.radius,
    this.width,
    this.textInputType,
    this.label,
    this.suffixIcon,
    this.hintStyle,
    this.controller,
    this.filledColor,
    this.contentPadding,
    this.onSubmit,
    this.initialSelection,
    this.onChange,
    this.isPassword = false,
    this.isPhone = false,
    this.isNumber = false,
    this.isSearch = false,
    this.isDate = false,
    this.icon,
    this.onTapVisible,
    this.labelStyle,
    this.onValidate,
    this.isChat = false,
    this.prefixIcon,
    this.prefix,
    this.fillColor,
    this.textInputAction,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // var w = MediaQuery.of(context).size.width;
    return Container(
      margin: isSearch
          ? EdgeInsets.symmetric(
              horizontal: 3.98 * (w / 100),
              vertical: isChat ? 1 * (w / 100) : 3.98 * (w / 100))
          : null,
      decoration: (isSearch && Get.find<AppController>().darkMode)
          ? AppDecoration.getGradientWithRadius(
              radius: 50 * (w / 100),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label?.tr ?? "",
              style: labelStyle ??
                  Get.theme.textTheme.labelLarge!
                      .copyWith(fontWeight: FontWeight.w700),
              maxLines: maxLines ?? 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 2.48 * (w / 100),
            ),
          ],
          Directionality(
            textDirection: isPhone || isNumber
                ? TextDirection.ltr
                : Get.find<AppController>().lang.value.languageCode == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: SizedBox(
              // height: (1 * w) / 6.66,
              child: TextFormField(
                inputFormatters: inputFormatters,
                onTapOutside: (event) => onTapOutside != null
                    ? onTapOutside!()
                    : FocusScope.of(context).unfocus(),
                enableInteractiveSelection: true,
                obscureText: !isVisible,
                textInputAction: textInputAction,
                keyboardType:
                    isPhone || isNumber ? TextInputType.phone : textInputType,
                onTap: onTap,
                onChanged: onChange,
                onFieldSubmitted: onSubmit,
                validator: onValidate,
                maxLines: maxLines ?? 1,

                // autocorrect: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: readOnly!,
                controller: controller,
                style: getRegularStyle(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite
                        : Colors.black,
                    fontSize: AppTextStyle.size16),
                cursorColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
                decoration: InputDecoration(
                  errorStyle: isThereError ? null : TextStyle(fontSize: 0),
                  enabled: enabled!,
                  filled: (isSearch && Get.find<AppController>().darkMode)
                      ? false
                      : true,
                  fillColor: fillColor ??
                      ((isSearch && !Get.find<AppController>().darkMode)
                          ? AppLightColors.searchTextField
                          : null),
                  border: isSearch ? searchFeild : kOutlinedBorderWhite,
                  focusedBorder:
                      isSearch || isChat ? searchFeild : kOutlinedBorderWhite,
                  enabledBorder:
                      isSearch || isChat ? searchFeild : kOutlinedBorderWhite,
                  errorBorder:
                      isSearch || isChat ? searchFeild : kOutlinedBorderRed,
                  suffixIcon: isPassword == true
                      ? GestureDetector(
                          onTap: () => onTapVisible!(),
                          child: AppIcon(
                            padding: EdgeInsets.all(3.48 * (w / 100)),
                            path: isVisible ? AppIcons.eye : AppIcons.eyeLock,
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.pureWhite.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                          ),
                        )
                      : suffixIcon,
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(
                        vertical: 3.48 * (w / 100),
                        horizontal: 4.97 * (w / 100),
                      ),
                  hintText: hint?.tr ?? "",
                  errorText: null,
                  prefix: prefix,
                  prefixIcon: isPhone
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: CountryCodePicker(
                            // flagWidth: 0,
                            initialSelection: initialSelection,
                            padding: EdgeInsets.zero,
                            showFlag: false,
                            showFlagDialog: true,
                            enabled: true,
                            headerText: "Select Country".tr,
                            showDropDownButton: true,
                            headerTextStyle: TextStyle(
                                color: Get.find<AppController>().darkMode
                                    ? null
                                    : Colors.black),
                            searchStyle: TextStyle(
                                color: Get.find<AppController>().darkMode
                                    ? null
                                    : Colors.black),
                            dialogTextStyle: TextStyle(
                                color: Get.find<AppController>().darkMode
                                    ? null
                                    : Colors.black),
                            textStyle: getRegularStyle(
                                color: Get.find<AppController>().darkMode
                                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                                    : Colors.black,
                                fontSize: AppTextStyle.size14),
                            builder: (val) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 4.97 * (w / 100),
                                ),
                                Text(val!.dialCode.toString()),
                                SizedBox(
                                  width: 1.49 * (w / 100),
                                ),
                                AppIcon(
                                  path: AppIcons.arrowbottom,
                                  color: Get.find<AppController>().darkMode
                                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.5),
                                ),
                                SizedBox(
                                  width: 2.48 * (w / 100),
                                ),
                              ],
                            ),
                            closeIcon: Icon(
                              Icons.close,
                              color: Get.find<AppController>().darkMode
                                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                                  : AppLightColors.black,
                            ),
                            searchDecoration: InputDecoration(
                                prefixIconColor: Get.find<AppController>()
                                        .darkMode
                                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.5),
                                hintText: "search country".tr,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.48 * (w / 100),
                                  horizontal: 4.97 * (w / 100),
                                ),
                                enabled: true,
                                filled: true,
                                border: dropDownOutlinedBorder,
                                focusedBorder: dropDownOutlinedBorder,
                                enabledBorder: dropDownOutlinedBorder,
                                hintStyle: getRegularStyle(
                                    color: Get.find<AppController>().darkMode
                                        ? AppDarkColors.pureWhite
                                            .withOpacity(0.5)
                                        : Colors.black,
                                    fontSize: AppTextStyle.size14)),
                            dialogBackgroundColor:
                                Get.find<AppController>().darkMode
                                    ? AppDarkColors.darkScaffoldColor
                                    : AppLightColors.pureWhite,
                            barrierColor: Get.find<AppController>().darkMode
                                ? AppDarkColors.darkContainer.withOpacity(0.3)
                                : AppLightColors.shadow.withOpacity(0.3),

                            onChanged: (value) => onChangeCountryCode != null
                                ? onChangeCountryCode!(value)
                                : null,
                            // textStyle:,
                          ),
                        )
                      : isSearch
                          ? AppIcon(
                              padding: EdgeInsets.all(3.48 * (w / 100)),
                              path: AppIcons.searchIcon,
                              color: Get.find<AppController>().darkMode
                                  ? Colors.white
                                  : Colors.black,
                            )
                          : prefixIcon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
