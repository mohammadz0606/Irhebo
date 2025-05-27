import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

class NotificationsShimmer extends StatelessWidget {
  const NotificationsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 8; i++)
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
                padding: EdgeInsets.symmetric(vertical: 4.97 * (w / 100)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLoading(
                      width: 10.69 * (w / 100),
                      height: 10.69 * (w / 100),
                      radius: 50 * (w / 100),
                    ),
                    SizedBox(
                      width: 2.98 * (w / 100),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLoading(
                          height: 3 * (w / 100),
                          width: 40.16 * (w / 100),
                          radius: 10,
                        ),
                        SizedBox(
                          height: 2 * (w / 100),
                        ),
                        for (int i = 0; i < 2; i++)
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 1 * (w / 100)),
                            child: AppLoading(
                              height: 3 * (w / 100),
                              width: 60.16 * (w / 100),
                              radius: 5,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          )
      ],
    );
  }
}
