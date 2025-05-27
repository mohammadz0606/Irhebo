import 'package:flutter/material.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class AttachmentRow extends StatelessWidget {
  final List<MediaModel>? attachments;
  final Function(int) onTapAttachment;

  const AttachmentRow({
    super.key,
    required this.attachments,
    required this.onTapAttachment,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Wrap(
        runSpacing: 2.48 * (w / 100),
        spacing: 2.48 * (w / 100),
        children: [
          for (int i = 0; i < attachments!.length; i++)
            GestureDetector(
              onTap: () => onTapAttachment(i),
              child: AppImage(
                imageUrl: attachments?[i].mediaPath ?? "",
                height: 11.9 * (w / 100),
                width: 11.9 * (w / 100),
                radius: 8,
              ),
            ),
        ]);
  }
}
