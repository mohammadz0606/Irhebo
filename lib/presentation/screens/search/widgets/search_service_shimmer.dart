// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class SearchServiceShimmer extends StatelessWidget {
  final bool isTherePadding;
  const SearchServiceShimmer({
    super.key,
    this.isTherePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isTherePadding ? 3.98 * (w / 100) : 0),
      child: Column(
        children: [
          for (int i = 0; i < 7; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
              child: Container(
                // height: 16.9*(w/100),
                padding: EdgeInsets.symmetric(
                    vertical: 3.48 * (w / 100), horizontal: 3.98 * (w / 100)),
                width: 100 * (w / 100),
                decoration: AppDecoration.getDecorationWithRadius(
                    radius: 20,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : Colors.white),
                // decoration: Get.find<AppController>().darkMode
                //     ? AppDecoration.getDecorationWithRadius(
                //         radius: 20, color: AppDarkColors.darkContainer2)
                //     : AppDecoration.getDecorationWithShadow(radius: 20),
                child: Center(
                  child: Row(
                    children: [
                      AppLoading(
                        width: 21.89 * (w / 100),
                        height: 22.38 * (w / 100),
                        radius: 15,
                      ),
                      SizedBox(
                        width: 2.48 * (w / 100),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLoading(
                              height: 4 * (w / 100),
                              width: 50 * (w / 100),
                              radius: 10,
                            ),
                            SizedBox(
                              height: 3 * (w / 100),
                            ),
                            AppLoading(
                              height: 2.5 * (w / 100),
                              width: 20 * (w / 100),
                              radius: 5,
                            ),
                            SizedBox(
                              height: 3 * (w / 100),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLoading(
                                  height: 2.5 * (w / 100),
                                  width: 20 * (w / 100),
                                  radius: 5,
                                ),
                                AppLoading(
                                  height: 2.5 * (w / 100),
                                  width: 9.16 * (w / 100),
                                  radius: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
