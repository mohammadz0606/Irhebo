import 'package:url_launcher/url_launcher.dart';

import '../../app/global_imports.dart';

import 'app_button.dart';

class OpenFileItems extends StatelessWidget {
  const OpenFileItems({
    super.key,
    required this.fileName,
    required this.pathUrl,
  });

  final String fileName;
  final String? pathUrl;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(
          vertical: 3 * (w / 100), horizontal: 4 * (w / 100)),
      decoration: AppDecoration.getDecorationWithRadius(
        radius: 20,
        color: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : Colors.white,
      ),
      child: ListTile(
        title: Text(fileName),
        titleTextStyle: Get.theme.textTheme.labelLarge,
        trailing: AppButton(
          title: 'Open'.tr,
          width: 100,
          onPressed: () async {
            if (pathUrl == null) {
              AppSnackBar.openErrorSnackBar(message: 'File not found'.tr);
              return;
            }
            //final extension = path.extension(filePath).replaceFirst('.', '').toLowerCase();
            final uri = Uri.parse(pathUrl!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            } else {
              AppSnackBar.openErrorSnackBar(message: 'Cannot open the file'.tr);
            }
          },
        ),
      ),
    );
  }
}
