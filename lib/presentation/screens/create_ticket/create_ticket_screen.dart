import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/presentation/screens/create_ticket/create_ticket_controller.dart';
import 'package:irhebo/presentation/screens/create_ticket/widgets/create_ticket_form.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

class CreateTicketScreen extends GetView<CreateTicketController> {
  const CreateTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      appBar: NormalAppBar(
        title: "Add Ticket",
        color: Get.find<AppController>().darkMode ? null : Colors.white,
      ),
      body: const SingleChildScrollView(child: CreateTicketForm()),
      bottomNavigationBar: Obx(
        () => AppButton(
          isLoading: controller.isLoading,
          bottom: true,
          onPressed: controller.onSubmit,
          title: "Submit",
        ),
      ),
    );
  }
}
