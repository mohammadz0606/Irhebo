import 'dart:io';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/providers/upload_files.dart';
import '../../../widgets/app_icon.dart';

class UploadMultipleFile extends StatefulWidget {
  const UploadMultipleFile({super.key, required this.onFilesSelected});

  final Function(List<File> files) onFilesSelected;

  @override
  State<UploadMultipleFile> createState() => _UploadMultipleFileState();
}

class _UploadMultipleFileState extends State<UploadMultipleFile> {
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          height: 17.5 * (w / 100),
          width: 45 * (w / 100),
          alignment: Alignment.center,
          decoration: AppDecoration.getDecorationWithRadius(
            borderColor: AppLightColors.greenContainer,
            dark: Get.find<AppController>().darkMode,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : AppLightColors.unSelected,
            radius: 20.r,
          ),
          child: Consumer<UploadFilesProvider>(
            builder: (context, provider, child) {
              return IconButton(
                onPressed: () async {
                  List<File> pickFile = await provider.pickMultipleFile();

                  if (files.isEmpty) {
                    files = pickFile;
                  } else {
                    files.addAll(pickFile);
                  }

                  widget.onFilesSelected(files);

                  setState(() {});
                },
                icon: AppIcon(
                  color: AppLightColors.greenContainer,
                  path: AppIcons.upload,
                  width: 5.97 * (w / 100),
                  height: 5.97 * (w / 100),
                ),
              );
            },
          ),
        ),
        if (files.isNotEmpty) ...[
          ...files.map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(e.path.split('/').last),
              trailing: IconButton(
                onPressed: () {
                  files.remove(e);
                  widget.onFilesSelected(files);
                  setState(() {});
                },
                icon: const AppIcon(
                  path: AppIcons.delete,
                  color: AppLightColors.red,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
