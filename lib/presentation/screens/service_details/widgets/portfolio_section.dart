import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/portfolio_item.dart';
import 'package:irhebo/presentation/widgets/app_title_with_action.dart';

class PortfolioSection extends StatelessWidget {
  final List<DataModel>? portfolio;
  final Function(int i)? onTapPortfolio;

  const PortfolioSection({
    super.key,
    required this.portfolio,
    this.onTapPortfolio,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AppTitleWithAction(title: "Portfolio", services: true),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < portfolio!.length; i++)
                Row(
                  children: [
                    PortfolioItem(
                      portfoilo: portfolio![i],
                      onTapItem: () => onTapPortfolio!(i),
                    ),
                    SizedBox(
                      width: 3.98 * (w / 100),
                    )
                  ],
                )
            ],
          ),
        ),
        SizedBox(
          height: 6.21 * (w / 100),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
