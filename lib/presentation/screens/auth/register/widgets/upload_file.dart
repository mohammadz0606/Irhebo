import '../../../../../app/global_imports.dart';
import '../../../../../app/resources/images.dart';
import '../../../../widgets/app_icon.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      height: 17.5 * (w / 100),
      width: 40 * (w / 100),
      decoration: AppDecoration.getDecorationWithRadius(
        borderColor: AppLightColors.greenContainer,
        dark: Get.find<AppController>().darkMode,
        color: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : AppLightColors.unSelected,
        radius: 20.r,
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {},
        icon: AppIcon(
          path: AppIcons.upload,
          width: 5.97 * (w / 100),
          height: 5.97 * (w / 100),
        ),
      ),
    );
  }
}
