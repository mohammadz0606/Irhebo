import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/presentation/screens/create_ticket/create_ticket_controller.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/files_row.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/upload_attachment.dart';
import 'package:irhebo/presentation/widgets/app_text_field.dart';
import 'package:irhebo/presentation/widgets/dropdown_item.dart';
import 'package:irhebo/presentation/widgets/dropdown_widget.dart';

class CreateTicketForm extends GetWidget<CreateTicketController> {
  const CreateTicketForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(3.89 * (w / 100)),
        child: Form(
          key: controller.createTicketKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.97 * (w / 100),
              ),
              CustomDropdown<RequestModel>(
                itemBuilder: (context, item, isDisabled, isSelected) =>
                    DropdownItem(
                  label: item.title ?? "",
                ),
                label: "Request",
                showSearchBox: false,
                hintText: "Select request",
                items: controller.requestsControllerr.requests,
                onChanged: (value) => controller.onSelectRequest(value),
                // validator: AppValidators.validateGender,
                itemToString: (value) => value!.title.toString(),
              ),
              SizedBox(
                height: 5.97 * (w / 100),
              ),
              AppTextField(
                label: "Subject",
                controller: controller.subject,
                onValidate: AppValidators.validateField,
              ),
              SizedBox(
                height: 5.97 * (w / 100),
              ),
              AppTextField(
                label: "Details",
                maxLines: 5,
                controller: controller.issue,
                onValidate: AppValidators.validateField,
              ),
              SizedBox(
                height: 5.97 * (w / 100),
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
                height: 5.97 * (w / 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
