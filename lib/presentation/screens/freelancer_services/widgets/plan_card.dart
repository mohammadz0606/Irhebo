import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:irhebo/domain/providers/currency.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/models/new_models/currency_model.dart';
import '../../../../domain/models/new_models/plan_model.dart';
import '../../../../domain/providers/freelancer/service.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/dropdown_item.dart';
import '../../../widgets/dropdown_widget.dart';

class PlanCard extends StatefulWidget {
  const PlanCard({
    super.key,
    this.currentIndex,
  });

  final int? currentIndex;

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.2 * (w / 100),
                horizontal: 3.48 * (w / 100),
              ),
              width: w,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: AppDecoration.getDecorationWithRadius(
                radius: 8 * (w / 100),
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.fillColor
                    : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.isLoadingPlan)
                    const Center(child: CircularProgressIndicator.adaptive())
                  else
                    CustomDropdown<PlanModelData?>(
                      itemBuilder: (context, item, isDisabled, isSelected) =>
                          DropdownItem(
                        label: item?.title ?? "",
                      ),
                      showSearchBox: true,
                      label: "Plans",
                      hintText: "Plans Choices",
                      enabled: widget.currentIndex == 0
                          ? provider.plan.length > 1
                              ? false
                              : true
                          : (widget.currentIndex! == provider.planListUIndex) ? true : false,
                      // enabled:
                      //     provider.plan[widget.currentIndex ?? 0]?.id == null,
                      items: provider.planList ?? [],
                      onChanged: provider.onChangePlan,
                      value: provider.plan[widget.currentIndex ?? 0],
                      itemToString: (value) => value?.title ?? "",
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Price'.tr,
                    style: Get.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: provider
                              .priceController[widget.currentIndex ?? 0],
                          hint: 'Enter Price',
                          textInputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [digitsAmountOnly],
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Consumer<CurrencyProvider>(
                        builder: (context, currencyProvider, child) {
                          return Expanded(
                            child: _buildCurrencyDropDown(
                              provider,
                              w,
                              currencyProvider,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildRowField(
                    title: 'Delivery Day',
                    controller: provider
                        .deliveryDayController[widget.currentIndex ?? 0],
                  ),
                  const SizedBox(height: 15),
                  _buildRowField(
                    title: 'Revisions',
                    controller:
                        provider.revisionController[widget.currentIndex ?? 0],
                  ),
                  const SizedBox(height: 15),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Source file'.tr,
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    dense: true,
                    value: provider.sourceFile[widget.currentIndex ?? 0],
                    onChanged: provider.onChangeSourceFile,
                  )
                ],
              ),
            ),
            if (widget.currentIndex != null && widget.currentIndex != 0)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () =>
                      provider.removePlanAtIndex(widget.currentIndex ?? 1),
                  child: const AppIcon(
                    path: AppIcons.delete,
                    color: AppDarkColors.red,
                    height: 30,
                    width: 20,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  _buildRowField({
    required String title,
    required TextEditingController controller,
  }) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: Text(
            title.tr,
            style: Get.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 2,
          child: AppTextField(
            controller: controller,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }

  Container _buildCurrencyDropDown(
    ServiceProvider provider,
    double w,
    CurrencyProvider currencyProvider,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: DropdownSearch<CurrencyModelData>(
        selectedItem: provider.selectedCurrency,
        enabled: widget.currentIndex == 0,
        onChanged: provider.onSelectedCurrency,
        validator: null,
        compareFn: (item1, item2) => item1.id == item2.id,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        popupProps: PopupPropsMultiSelection<CurrencyModelData>.menu(
          itemBuilder: (context, item, isDisabled, isSelected) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text(item.symbolEn ?? ''),
          ),
          fit: FlexFit.loose,
          menuProps: MenuProps(
            backgroundColor: Get.find<AppController>().darkMode
                ? AppDarkColors.darkScaffoldColor
                : AppLightColors.pureWhite,
            barrierColor: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer.withOpacity(0.3)
                : AppLightColors.shadow.withOpacity(0.3),
          ),
          searchFieldProps: TextFieldProps(
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
              contentPadding: EdgeInsets.symmetric(
                vertical: 3.48 * (w / 100),
                horizontal: 4.97 * (w / 100),
              ),
            ),
          ),
          showSearchBox: true,
        ),
        itemAsString: (CurrencyModelData item) =>
            Get.locale?.languageCode == 'ar'
                ? item.symbolAr ?? ''
                : item.symbolEn ?? '',
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
          ),
        ),
        items: (filter, loadProps) async {
          return currencyProvider.currencyModel?.data ?? [];
        },
        decoratorProps: DropDownDecoratorProps(
          baseStyle: getRegularStyle(
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.pureWhite.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            fontSize: AppTextStyle.size16,
          ),
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
            contentPadding: EdgeInsets.symmetric(
              vertical: 3.48 * (w / 100),
              horizontal: 4.97 * (w / 100),
            ),
            hintText: 'Currency',
            hintStyle: getRegularStyle(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
              fontSize: AppTextStyle.size14,
            ),
          ),
        ),
      ),
    );
  }
}
