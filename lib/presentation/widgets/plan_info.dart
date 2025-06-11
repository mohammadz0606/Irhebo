import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/presentation/screens/request_details/widgets/request_info_widget.dart';

class PlanInfo extends StatelessWidget {
  final PlanModel? plan;
  const PlanInfo({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        //RequestInfoWidget(title: 'Price', count: plan?.price ?? ""),
        // SizedBox(
        //   height: 4 * (w / 100),
        // ),
        // RequestInfoWidget(
        //   title: 'Delivery Days',
        //   count: (plan?.deliveryDays ?? 0).toString(),
        // ),
        SizedBox(
          height: 4 * (w / 100),
        ),
        if (plan!.features != null)
          for (int i = 0; i < plan!.features!.length; i++)
            Column(
              children: [
                RequestInfoWidget(
                  title: plan?.features![i].title ?? "",
                  count: plan?.features![i].value,
                ),
                SizedBox(
                  height: 4 * (w / 100),
                ),
              ],
            ),
      ],
    );
  }
}
