import '../../../app/global_imports.dart';
import '../../../domain/models/new_models/chat/chat_messages_model.dart';
import '../../widgets/app_image.dart';
import '../../widgets/normal_app_bar.dart';
import '../bottom_nav_bar/screens/home/widgets/video_play_widget.dart';

class GalleryChatsScreen extends StatefulWidget {
  const GalleryChatsScreen({
    super.key,
    required this.images,
    required this.isVideo,
    required this.currentPath,
  });

  final List<ChatMessagesModelDataMessages> images;
  final bool isVideo;
  final String currentPath;

  @override
  State<GalleryChatsScreen> createState() => _GalleryChatsScreenState();
}

class _GalleryChatsScreenState extends State<GalleryChatsScreen> {
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  int pageIndex = 0;

  @override
  void initState() {
    int currentIndex = widget.images.indexOf(widget.images
        .firstWhere((element) => element.attachmentUrl == widget.currentPath));
    pageIndex = currentIndex;
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(title: 'Gallery'),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  pageIndex = value;
                  setState(() {});
                },
                controller: pageController,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    widget.isVideo
                        ? VideoMediaWidget(
                            mediaUrl: widget.images[i].attachmentUrl ?? '')
                        : AppImage(
                            imageUrl: widget.images[i].attachmentUrl ?? '',
                            fit: BoxFit.contain,
                          )
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < widget.images.length; i++)
                      Padding(
                        padding: pageIndex == i
                            ? EdgeInsets.symmetric(horizontal: 5 * (w / 100))
                            : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            pageIndex = i;
                            pageController.jumpToPage(i);
                            setState(() {});
                          },
                          child: widget.isVideo
                              ? VideoMediaWidget(mediaUrl: widget.images[i].attachmentUrl ?? "")
                              : AppImage(
                            imageUrl: widget.images[i].attachmentUrl ?? "",
                            width: 10 * (w / 100),
                            height: 10 * (w / 100),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10 * (w / 100),
            )
          ],
        ),
      ),
    );
  }
}
