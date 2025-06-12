import 'dart:io';

import '../../../../app/global_imports.dart';
import '../../../../app/resources/images.dart';
import '../../../../domain/providers/files_manager.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/open_file_items.dart';

class UploadMultipleFile extends StatefulWidget {
  const UploadMultipleFile(
      {super.key, required this.onFilesSelected, this.urlsImage});

  final Function(List<File> files) onFilesSelected;
  final List<String>? urlsImage;

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
        if (files.isNotEmpty) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          files[index],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            files.remove(files[index]);
                            widget.onFilesSelected(files);
                            setState(() {});
                          },
                          icon: const AppIcon(
                            path: AppIcons.delete,
                            color: AppLightColors.pureWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          height: 20.5 * (w / 100),
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
          child: Consumer<FilesManagerProvider>(
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
        // if (files.isNotEmpty) ...[
        //   ...files.map(
        //     (e) => ListTile(
        //       contentPadding: EdgeInsets.zero,
        //       title: Text(e.path.split('/').last),
        //       trailing: IconButton(
        //         onPressed: () {
        //           files.remove(e);
        //           widget.onFilesSelected(files);
        //           setState(() {});
        //         },
        //         icon: const AppIcon(
        //           path: AppIcons.delete,
        //           color: AppLightColors.red,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
        if (files.isEmpty && widget.urlsImage != null) ...{
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.urlsImage!.length,
            itemBuilder: (context, index) {
              return OpenFileItems(
                pathUrl: widget.urlsImage![index],
                fileName: extractFileName(widget.urlsImage![index]),
              );
            },
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
