import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class FilesRow extends StatelessWidget {
  final List<Uint8List> imageBytes;
  final Function(int) onOpenFile;
  final Function(int) onDismissFile;

  const FilesRow({
    super.key,
    required this.imageBytes,
    required this.onOpenFile,
    required this.onDismissFile,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Wrap(
      runSpacing: 2.48 * (w / 100),
      spacing: 2.48 * (w / 100),
      children: [
        for (int i = 0; i < imageBytes.length; i++)
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () => onOpenFile(i),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                      width: 20 * (w / 100),
                      height: 20 * (w / 100),
                      child: Image.memory(
                        imageBytes[i],
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                width: 8 * (w / 100),
                height: 8 * (w / 100),
                child: IconButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            WidgetStateProperty.all(AppLightColors.red)),
                    onPressed: () => onDismissFile(i),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 4.5 * (w / 100),
                    )),
              )
            ],
          )
      ],
    );
  }
}
