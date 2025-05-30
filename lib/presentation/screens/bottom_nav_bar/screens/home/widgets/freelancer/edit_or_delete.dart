import '../../../../../../../app/global_imports.dart';
import '../../../../../../../app/resources/images.dart';
import '../../../../../../widgets/decorated_icon.dart';

class EditOrDelete extends StatelessWidget {
  const EditOrDelete({
    super.key,
    required this.id,
    this.space = 36,
  });

  final int id;
  final double space;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: DecoratedIcon(
            width: 8.2 * (w / 100),
            height: 8.2 * (w / 100),
            padding: 1.69 * (w / 100),
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.primaryColor
                : AppLightColors.secondary,
            imagePath: AppIcons.edit,
            svgColor: AppDarkColors.pureWhite,
          ),
        ),
        SizedBox(width: space * (w / 100)),
        GestureDetector(
          onTap: () {},
          child: DecoratedIcon(
            width: 8.2 * (w / 100),
            height: 8.2 * (w / 100),
            padding: 1.69 * (w / 100),
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.primaryColor
                : AppLightColors.secondary,
            imagePath: AppIcons.delete,
            svgColor: AppDarkColors.pureWhite,
          ),
        ),
      ],
    );
  }
}
