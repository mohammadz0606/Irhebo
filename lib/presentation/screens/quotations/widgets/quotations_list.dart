import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/custome_paginagtion_footer.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_controller.dart';
import 'package:irhebo/presentation/screens/quotations/widgets/quotation_widget.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:irhebo/presentation/widgets/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuotationsList extends GetWidget<QuotationsController> {
  const QuotationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefreshQuotationsList,
      enablePullDown: true,
      enablePullUp: true,
      footer: CustomePaginagtionFooter(),
      onLoading: controller.getQuotations,
      child: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
            child: controller.isLoading
                ? Column(
                    children: [
                      for (int i = 0; i < 8; i++)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
                          child: AppLoading(
                            height: 38.8 * (w / 100),
                            width: 100 * (w / 100),
                            radius: 18,
                          ),
                        )
                    ],
                  )
                : controller.quotations.isEmpty
                    ? NoData(
                        forHome: false,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < controller.quotations.length; i++)
                            GestureDetector(
                              onTap: () => controller.onTapQuotaion(i),
                              child: QuotationWidget(
                                quotation: controller.quotations[i],
                              ),
                            )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
