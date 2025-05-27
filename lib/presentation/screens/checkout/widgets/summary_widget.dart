import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/checkout_model.dart';
import 'package:irhebo/presentation/screens/checkout/widgets/price_row.dart';

class SummaryWidget extends StatelessWidget {
  final CheckoutModel model;
  const SummaryWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: AppDecoration.getDecorationWithRadius(
          radius: 10,
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer2
              : AppLightColors.pureWhite),
      padding: EdgeInsets.symmetric(
          vertical: 3.73 * (w / 100), horizontal: 4.47 * (w / 100)),
      child: Column(
        children: [
          PriceRow(
            title: "Sub Total",
            price: model.subTotal ?? "",
          ),
          // SizedBox(
          //   height: 4.97 * (w / 100),
          // ),
          // PriceRow(
          //   title: "Discount",
          //   price: model.subTotal ?? "",
          //   discount: true,
          // ),
          // SizedBox(
          //   height: 4.97 * (w / 100),
          // ),
          // PriceRow(
          //   title: "Service Fees",
          //   price: model.subTotal ?? "",
          // ),
          SizedBox(
            height: 4.97 * (w / 100),
          ),
          PriceRow(
            title: "Tax",
            price: model.tax ?? "",
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),
            child: Divider(
              height: 1,
            ),
          ),
          PriceRow(
            title: "Order Total",
            price: model.total ?? "",
            total: true,
          ),
        ],
      ),
    );
  }
}
