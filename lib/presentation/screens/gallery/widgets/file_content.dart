import 'dart:typed_data';

import 'package:flutter/material.dart';

class FileContent extends StatelessWidget {
  final List<Uint8List> files;
  final PageController? pageController;
  final Function(int) onPageChanged;
  const FileContent(
      {super.key,
      required this.files,
      required this.pageController,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        children: [
          for (int i = 0; i < files.length; i++)
            SizedBox(
                // width: 15 * (w / 100),
                // height: 15 * (w / 100),
                child: Image.memory(files[i])),
        ],
      ),
    );
  }
}
