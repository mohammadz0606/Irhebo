import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/portfolio_item.dart';

class FreelancerPortfolio extends StatelessWidget {
  final List<DataModel>? portfolios;
  final Function(int) onTapPortfolio;
  const FreelancerPortfolio(
      {super.key, required this.portfolios, required this.onTapPortfolio});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Wrap(
      spacing: 3.98 * (w / 100),
      runSpacing: 3.98 * (w / 100),
      children: [
        for (int i = 0; i < portfolios!.length; i++)
          PortfolioItem(
            freelancer: true,
            portfoilo: portfolios![i],
            onTapItem: () => onTapPortfolio(i),
          ),
      ],
    );
  }
}
