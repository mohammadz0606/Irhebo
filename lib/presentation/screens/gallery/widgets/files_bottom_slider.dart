import 'dart:typed_data';

import 'package:flutter/material.dart';

class FilesBottomSlider extends StatelessWidget {
  final List<Uint8List> files;
  final ScrollController scrollController;
  final int pageIndex;
  final Function(int) onTapSliderImage;
  const FilesBottomSlider(
      {super.key,
      required this.files,
      required this.pageIndex,
      required this.onTapSliderImage,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          // width: 1 * w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < files.length; i++)
                Padding(
                  padding: pageIndex == i
                      ? EdgeInsets.symmetric(horizontal: 5 * (w / 100))
                      : EdgeInsets.zero,
                  child: GestureDetector(
                    onTap: () => onTapSliderImage(i),
                    child: SizedBox(
                      width: 10 * (w / 100),
                      height: 10 * (w / 100),
                      child: Image.memory(
                        files[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
