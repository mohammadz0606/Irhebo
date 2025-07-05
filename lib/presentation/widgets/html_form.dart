import 'package:flutter_quill/flutter_quill.dart';

import '../../app/global_imports.dart';

class HtmlFormat extends StatefulWidget {
  const HtmlFormat({super.key, required this.quillController});

  final QuillController quillController;

  @override
  State<HtmlFormat> createState() => _HtmlFormatState();
}

class _HtmlFormatState extends State<HtmlFormat> {
  //final QuillController quillController = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.quillController.readOnly = false;

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    //widget.quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        QuillSimpleToolbar(
          controller: widget.quillController,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: QuillEditor.basic(
            controller: widget.quillController,
            focusNode: _focusNode,
            scrollController: _scrollController,
            config: QuillEditorConfig(
              padding: const EdgeInsets.all(8),
              autoFocus: true,
              scrollPhysics: const ClampingScrollPhysics(),
              onTapOutside: (event, focusNode) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
      ],
    );
  }
}
