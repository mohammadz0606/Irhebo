import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';

import '../../../../app/global_imports.dart';

class ViewHtmlDetails extends StatefulWidget {
  const ViewHtmlDetails({super.key, required this.html});
  final String html;

  @override
  State<ViewHtmlDetails> createState() => _ViewHtmlDetailsState();
}

class _ViewHtmlDetailsState extends State<ViewHtmlDetails> {
  QuillController quillController = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    quillController.readOnly = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      quillController = await quillControllerFromHtml(widget.html ?? '');
    });

    super.initState();
  }

  @override
  void dispose() {
    quillController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<QuillController> quillControllerFromHtml(String html) async {
    final delta = HtmlToDelta().convert(html, transformTableAsEmbed: false);
    return QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuillEditor.basic(
      controller: quillController,
      focusNode: _focusNode,
      scrollController: _scrollController,
      config: QuillEditorConfig(
        padding: const EdgeInsets.all(8),
        autoFocus: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        onTapOutside: (event, focusNode) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
