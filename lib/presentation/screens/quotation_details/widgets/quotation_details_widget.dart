import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/presentation/screens/quotation_details/widgets/quotation_attribute_row.dart';
import 'package:irhebo/presentation/screens/quotation_details/widgets/quotation_details_user_info_row.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';

import '../../../../app/router/routes.dart';
import '../../../widgets/app_image.dart';
import '../quotation_details_controller.dart';

class QuotationDetailsWidget extends GetView<QuotationDetailsController> {
  final QuotationModel quotation;

  const QuotationDetailsWidget({
    super.key,
    required this.quotation,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                        style: Get.theme.textTheme.bodySmall?.copyWith(
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
                const Divider(),
                SizedBox(
                  height: 5.97 * (w / 100),
                ),
                if(getUserRole == UserRoles.freelancer)
                Text(
                  'Comments'.tr,
                  style: Get.theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.97 * (w / 100),
          ),
          if(getUserRole == UserRoles.freelancer)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quotation.comments?.length ?? 0,
            itemBuilder: (context, index) {
              var data = quotation.comments?[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.freelancerProfile,
                          arguments: {"id": data?.user?.id ?? 0});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppImage(
                              imageUrl: data?.user?.avatar ?? "",
                              width: 7.46 * (w / 100),
                              height: 7.46 * (w / 100),
                              radius: 25,
                            ),
                            SizedBox(
                              width: 2.73 * (w / 100),
                            ),
                            Text(
                              data?.user?.username ?? "",
                              style: Get.theme.textTheme.labelMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(
                          quotation.createdAt ?? "",
                          style: Get.theme.textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    data?.comment ?? "",
                    style: Get.theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: AppButton(
                          padding: EdgeInsets.zero,
                          hieght: 20.w,
                          width: 150.w,
                          isLoading: controller.isLoadingApproveQuotation &&
                              controller.loadingCommentId.value == data?.id,
                          title: 'Approve Quotation',
                          onPressed: () async {
                            await controller.approveQuotation(
                              commentId: data?.id ?? 0,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Column(
                children: [
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
          //const Spacer(),
          // Obx(() {
          //   return AppButton(
          //     isLoading: controller.isLoadingApproveQuotation,
          //     title: 'Approve Quotation',
          //     onPressed: () async {
          //       await controller.approveQuotation();
          //     },
          //   );
          // },),
          //const SizedBox(height: 5),
        ],
      ),
    );
  }
}
