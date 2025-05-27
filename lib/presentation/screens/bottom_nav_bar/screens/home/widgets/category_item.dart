// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool homeCategory;
  const CategoryItem({
    super.key,
    required this.category,
    this.homeCategory = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: homeCategory ? 2.73 * (w / 100) : 0,
          vertical: homeCategory ? 2.48 * (w / 100) : 0),
      child: Column(
        children: [
          DecoratedIcon(
            width: 16.16 * (w / 100),
            height: 16.16 * (w / 100),
            networkImage: true,
            padding: 4.97 * (w / 100),
            imagePath: category.icon ?? "",
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          SizedBox(
            width: 16.16 * (w / 100),
            child: Text(
              category.title ?? "",
              style: Get.theme.textTheme.labelMedium,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
