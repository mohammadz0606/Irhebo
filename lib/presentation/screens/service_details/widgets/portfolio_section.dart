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
        const AppTitleWithAction(title: "Portfolio", services: true),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        // padding:  EdgeInsets.zero,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: List.generate(portfolio!.length, (i) {
        //       return Padding(
        //         padding: EdgeInsets.only(right: i == portfolio!.length - 1 ? 0 : 16),
        //         child: PortfolioItem(
        //           portfoilo: portfolio![i],
        //           onTapItem: () => onTapPortfolio!(i),
        //         ),
        //       );
        //     }),
        //   ),
        // ),

        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0, right: 16), // تأكد من left=0
            itemCount: portfolio!.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(right: i == portfolio!.length - 1 ? 0 : 16),
                child: PortfolioItem(
                  portfoilo: portfolio![i],
                  onTapItem: () => onTapPortfolio!(i),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 6.21 * (w / 100),
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
