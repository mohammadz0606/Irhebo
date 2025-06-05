import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/files_row.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/upload_attachment.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/dropdown_item.dart';
import 'package:irhebo/presentation/widgets/dropdown_widget.dart';

class UpdateRequestDialog extends GetWidget<RequestDetailsController> {
  const UpdateRequestDialog({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: 6.21 * (w / 100),
          right: 6.21 * (w / 100),
          left: 6.21 * (w / 100),
          bottom: 6.21 * (w / 100)),
      child: Obx(
        () => Form(
          key: controller.updateRequestKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Update".tr,
                style: Get.theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                  "Keep the job poster updated by adding comments, progress updates, and attachments"
                      .tr,
                  style: Get.theme.textTheme.labelMedium),
              SizedBox(
                height: 5.9 * (w / 100),
              ),
              // CustomDropdown<String>(
              //   itemBuilder: (context, item, isDisabled, isSelected) =>
              //       DropdownItem(
              //     label: item,
              //   ),
              //   showSearchBox: false,
              //   label: "Status",
              //   hintText: "Change Status",
              //   items: controller.types,
              //   onChanged: controller.onChangeStatus,
              //   validator: AppValidators.validateStatus,
              //   itemToString: (value) => value!.toString(),
              // ),
              SizedBox(
                height: 5.9 * (w / 100),
              ),
              AppTextField(
                label: "Comments",
                hint: "Type your comments and updates here",
                maxLines: 2,
                controller: controller.commentController,
                onValidate: AppValidators.validateField,
              ),
              SizedBox(
                height: 5.9 * (w / 100),
              ),
              if (controller.selectedFilePath.isNotEmpty) ...[
                FilesRow(
                  imageBytes: controller.imageBytes,
                  onDismissFile: controller.dismissFile,
                  onOpenFile: controller.onOpenFile,
                ),
                SizedBox(
                  height: 5.97 * (w / 100),
                ),
              ],
              UploadAttachment(
                onOpenFile: controller.addAttachments,
              ),
              SizedBox(
                height: 5.9 * (w / 100),
              ),
              Center(
                child: AppButton(
                  hieght: 12.43 * (w / 100),
                  width: 76.11 * (w / 100),
                  isLoading: controller.isLoadingUpdate,
                  backGroundColor: AppDarkColors.greenContainer,
                  onPressed: () async {
                    await controller.onUpadteRequest(status: status);
                  },
                  title: "Add Update",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
