import 'package:flutter_html/flutter_html.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/global_imports.dart';

class ViewHtmlDetails extends StatefulWidget {
  const ViewHtmlDetails({super.key, required this.html});

  final String html;

  @override
  State<ViewHtmlDetails> createState() => _ViewHtmlDetailsState();
}

class _ViewHtmlDetailsState extends State<ViewHtmlDetails> {
  //QuillController quillController = QuillController.basic();
  final QuillEditorController _controller = QuillEditorController();

  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    //quillController.dispose();
    _scrollController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Future<QuillController> quillControllerFromHtml(String html) async {
  //   final delta = HtmlToDelta().convert(html, transformTableAsEmbed: false);
  //   return QuillController(
  //     document: Document.fromDelta(delta),
  //     selection: const TextSelection.collapsed(offset: 0),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: widget.html,
        onLinkTap: (url, attributes, element) async {
          if (url != null && await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication);
          } else {
            AppSnackBar.openErrorSnackBar(title: 'can not launch url'.tr);
          }
        },
        // style: {
        //   "body": Style(
        //     fontSize: FontSize(16.0),
        //   ),
        // },
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return QuillHtmlEditor(
//     controller: _controller,
//     isEnabled: false,
//     hintText: '',
//     text: widget.html,
//     textStyle: const TextStyle(fontSize: 16),
//     backgroundColor: Colors.transparent,
//     minHeight: 200,
//     ensureVisible: true,
//     // isLinkPreview: true,
//     // onTapUrl: (url) async {
//     //   if (await canLaunchUrl(Uri.parse(url))) {
//     //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     //   } else {
//     //     debugPrint('تعذر فتح الرابط: $url');
//     //   }
//     // },
//   );
// }
}

// @override
// Widget build(BuildContext context) {
//   return QuillEditor.basic(
//     controller: quillController,
//     focusNode: _focusNode,
//     scrollController: _scrollController,
//     config: QuillEditorConfig(
//       padding: const EdgeInsets.all(8),
//       autoFocus: true,
//       scrollPhysics: const NeverScrollableScrollPhysics(),
//       onTapOutside: (event, focusNode) {
//         FocusScope.of(context).unfocus();
//       },
//     ),
//   );
// }
