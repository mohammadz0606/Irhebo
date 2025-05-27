import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/presentation/screens/quotation_details/widgets/quotation_attribute_row.dart';
import 'package:irhebo/presentation/screens/quotation_details/widgets/quotation_details_user_info_row.dart';

class QuotationDetailsWidget extends StatelessWidget {
  final QuotationModel quotation;

  const QuotationDetailsWidget({
    super.key,
    required this.quotation,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8.2 * (w / 100), horizontal: 3.48 * (w / 100)),
      width: w,
      decoration: AppDecoration.getDecorationWithRadius(
        radius: 4.4 * (w / 100),
        color: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer
            : Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuotationDetailsUserInfoRow(
            quotation: quotation,
          ),
          SizedBox(
            height: 5.97 * (w / 100),
          ),
          Text(
            quotation.title ?? "",
            style: Get.theme.textTheme.labelLarge,
          ),
          SizedBox(
            height: 2 * (w / 100),
          ),
          Text(
            quotation.description ?? "",
            style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.67 * (w / 100),
          ),
          QuotationAttributeRow(
            title: "Price",
            value: quotation.price ?? "",
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          QuotationAttributeRow(
            title: "Delivery Day",
            value: quotation.deliveryDay.toString(),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          QuotationAttributeRow(
            title: "Revisions",
            value: quotation.revisions.toString(),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          Row(
            children: [
              SizedBox(
                width: 4.97 * (w / 100),
                height: 4.97 * (w / 100),
                child: Checkbox(
                  activeColor: Get.find<AppController>().darkMode
                      ? AppDarkColors.greenContainer
                      : AppLightColors.secondary,
                  value: quotation.sourceFile,
                  onChanged: (value) => {},
                ),
              ),
              SizedBox(
                width: 3 * (w / 100),
              ),
              Text("Source file".tr,
                  style: Get.theme.textTheme.bodySmall!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? Colors.white
                          : Colors.black)),
            ],
          ),
          SizedBox(
            height: 5.97 * (w / 100),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     AppButton(
          //       onPressed: () => Get.back(),
          //       title: 'Apply for Quotation',
          //       backGroundColor: AppDarkColors.primaryColor,
          //       width: 76.11 * (w / 100),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
