import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:irhebo/domain/providers/files_manager.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../app/resources/images.dart';
import '../../../../widgets/app_icon.dart';

class UploadFileWidget extends StatefulWidget {
  const UploadFileWidget({
    super.key,
    required this.onFileSelected,
    this.fileType = FileType.any,
  });

  final Function(File? file) onFileSelected;
  final FileType fileType;

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      height: 17.5 * (w / 100),
      width: 45 * (w / 100),
      decoration: AppDecoration.getDecorationWithRadius(
        borderColor: AppLightColors.greenContainer,
        dark: Get.find<AppController>().darkMode,
        color: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : AppLightColors.unSelected,
        radius: 20.r,
      ),
      alignment: Alignment.center,
      child: Consumer<FilesManagerProvider>(
        builder: (context, provider, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !provider.isLoadingPickFile,
                replacement: const CircularProgressIndicator(),
                child: IconButton(
                  onPressed: () async {
                    if (file != null) {
                      file = null;
                      widget.onFileSelected(file);
                      setState(() {});
                    }

                    File? pickFile = await provider.pickFile(fileType: widget.fileType);

                    file = pickFile;

                    widget.onFileSelected(file);

                    setState(() {});
                  },
                  icon: AppIcon(
                    color: AppLightColors.greenContainer,
                    path:
                        file == null ? AppIcons.upload : AppIcons.attachment,
                    width: 5.97 * (w / 100),
                    height: 5.97 * (w / 100),
                  ),
                ),
              ),
              if (file != null) ...{
                Text(
                  file!.path.split('/').last,
                  style: Get.textTheme.bodySmall,
                ),
              },
            ],
          );
        },
      ),
    );
  }
}
