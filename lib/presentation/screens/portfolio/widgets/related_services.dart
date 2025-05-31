import 'dart:developer';

import 'package:irhebo/domain/providers/freelancer/freelancer_services.dart';
import 'package:irhebo/presentation/widgets/multi_dropdown_widget.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_service_model.dart';
import '../../../../domain/params/new_params/freelanser/freelancer_service_param.dart';

class RelatedServicesWidget extends StatefulWidget {
  const RelatedServicesWidget({super.key});

  @override
  State<RelatedServicesWidget> createState() => _RelatedServicesWidgetState();
}

class _RelatedServicesWidgetState extends State<RelatedServicesWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<FreelancerServicesProvider>(context, listen: false)
          .getFreeLancerServices(data: FreelancerServiceParam());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FreelancerServicesProvider>(
      builder: (
        BuildContext context,
        FreelancerServicesProvider value,
        Widget? _,
      ) {
        if (value.isLoading || value.freelancerServiceModel == null) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(Get.theme.primaryColor),
            ),
          );
        } else {
          return MultiCustomDropdown<FreelancerServiceModelDataServices?>(
            items: value.freelancerServiceModel!.data!.services!.map(
              (e) {
                return MultiSelectItem<FreelancerServiceModelDataServices?>(
                  e,
                  e?.title ?? '',

                );
              },
            ).toList(),
            buttonText: 'Related Services Choices',
            label: 'Related Services',
            titleStyle: Get.textTheme.labelMedium,
            showSelected: true,
            onConfirm: (value) {
              log('LEN SELECTED SERVICE ${value.length}');

            },
          );
        }
      },
    );
  }
}
