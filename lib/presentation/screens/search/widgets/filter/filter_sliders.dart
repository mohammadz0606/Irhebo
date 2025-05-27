// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:irhebo/domain/models/home_model.dart';
// import 'package:irhebo/presentation/screens/search/widgets/filter/widgets/budget_slider.dart';
// import 'package:irhebo/presentation/screens/search/search_controller.dart'
//     as sr;

// class FilterSliders extends GetWidget<sr.SearchController> {
//   final List<FilterModel> filters;

//   const FilterSliders({super.key, required this.filters});

//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int i = 0; i < filters.length; i++)
//           Column(
//             children: [
//               Obx(
//                 () => BudgetSlider(
//                   maxLabel: filters[i].max!.toDouble(),
//                   minLabel: filters[i].min!.toDouble(),
//                   maxSlider: 500, // Set a max range limit
//                   minSlider: 0, // Set a min range limit
//                   maxSliderController: TextEditingController(),
//                   minSliderController: TextEditingController(),
//                   onMinFieldSubmitted: (value) => controller.onChangeMinField(
//                       i,
//                       double.tryParse(value),
//                       RangeValues(filters[i].min!.toDouble(),
//                           filters[i].max!.toDouble())),

//                   onMaxFieldSubmitted: (value) => controller.onChangeMaxField(
//                       i,
//                       double.tryParse(value),
//                       RangeValues(filters[i].min!.toDouble(),
//                           filters[i].max!.toDouble())),

//                   onChangeSlider: (range) =>
//                       controller.changeBudgetRange(i, range),
//                 ),
//               ),
//               SizedBox(height: 2.4 * (w / 100)),
//             ],
//           ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
//           child: Divider(),
//         ),
//       ],
//     );
//   }
// }
