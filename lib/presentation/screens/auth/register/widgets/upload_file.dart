import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:irhebo/domain/providers/files_manager.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../app/resources/images.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/open_file_items.dart';

class UploadFileWidget extends StatefulWidget {
  const UploadFileWidget({
    super.key,
    required this.onFileSelected,
    this.fileType = FileType.any,
    this.imageStartUrl,
  });

  final Function(File? file) onFileSelected;
  final FileType fileType;
  final String? imageStartUrl;

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 30),
          height: 20.5 * (w / 100),
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
              return Stack(
                children: [
                  if (file != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.file(
                          file!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (!provider.isLoadingPickFile)
                    Center(
                      child: IconButton(
                        onPressed: () async {
                          if (file != null) {
                            file = null;
                            widget.onFileSelected(file);
                            setState(() {});
                          }

                          File? pickFile = await provider.pickFile(
                              fileType: widget.fileType);

                          file = pickFile;
                          widget.onFileSelected(file);
                          setState(() {});
                        },
                        icon: file == null
                            ? AppIcon(
                                color: AppLightColors.greenContainer,
                                path:
                                    file == null || widget.imageStartUrl == null
                                        ? AppIcons.upload
                                        : AppIcons.attachment,
                                width: 5.97 * (w / 100),
                                height: 5.97 * (w / 100),
                              )
                            : const SizedBox(),
                      ),
                    )
                  else
                    const Center(child: CircularProgressIndicator.adaptive()),
                ],
              );
            },
          ),
        ),
        if (file != null) ...{
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              file!.path.split('/').last,
              style: Get.textTheme.bodySmall,
            ),
            trailing: IconButton(
              onPressed: () {
                file = null;
                widget.onFileSelected(null);
                setState(() {});
              },
              icon: const AppIcon(
                path: AppIcons.delete,
                color: AppLightColors.red,
              ),
            ),
          ),
          const SizedBox(height: 20),
        },
        if (file == null && widget.imageStartUrl != null) ...{
          OpenFileItems(
            pathUrl: widget.imageStartUrl,
            fileName: extractFileName(widget.imageStartUrl!),
          ),
          const SizedBox(height: 20),
        },
      ],
    );
  }

  String extractFileName(String url) {
    return Uri.parse(url).pathSegments.last;
  }
}
