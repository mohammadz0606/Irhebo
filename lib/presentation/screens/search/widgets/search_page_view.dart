// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:irhebo/presentation/screens/search/widgets/subcategory_services_page_view_item.dart';
import 'package:irhebo/presentation/screens/search/widgets/service_page_view_item.dart';
import 'package:irhebo/presentation/screens/search/widgets/subcategory_page_view_item.dart';

class SearchPageView extends StatelessWidget {
  final PageController controller;
  final Function(int index) onPageChanged;

  const SearchPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: onPageChanged,
        children: const [
          SubCategoryAndServicesPageViewItem(),
          SubCategoryPageViewItem(),
          ServicePageViewItem(),
        ],
      ),
    );
  }
}
//onTapSubCategory