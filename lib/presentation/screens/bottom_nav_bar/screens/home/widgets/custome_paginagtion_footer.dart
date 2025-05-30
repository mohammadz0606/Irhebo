import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomePaginagtionFooter extends StatelessWidget {
  const CustomePaginagtionFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pull up load".tr);
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator(
              animating: true, color: Theme.of(context).primaryColor);
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Failed, Click retry".tr);
        } else if (mode == LoadStatus.canLoading) {
          body = Text("release to load more".tr);
        } else {
          body = const SizedBox();
        }
        return Container(
          padding: const EdgeInsets.only(bottom: 20),
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
