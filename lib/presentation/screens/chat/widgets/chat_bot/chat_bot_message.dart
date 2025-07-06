import 'package:irhebo/domain/models/login_model.dart';

import '../../../../../app/global_imports.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../domain/models/home_model.dart';
import '../../../../../domain/models/new_models/chat/chat_bot_messages_model.dart';
import '../../../bottom_nav_bar/screens/home/widgets/service_item.dart';
import '../../../service_details/service_details_screen.dart';

class ChatBotMessage extends StatelessWidget {
  const ChatBotMessage({super.key, required this.botMessagesModelMessages});

  final BotMessagesModelMessages botMessagesModelMessages;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Align(
      alignment: botMessagesModelMessages.role == 'user'
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom: 3.48 * (w / 100),
          start: 5.97 * (w / 100),
          end: 5.97 * (w / 100),
        ),
        child: Column(
          crossAxisAlignment: botMessagesModelMessages.role == 'user'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 5 * (w / 100),
                left: 5 * (w / 100),
                top: 3 * (w / 100),
                bottom: 3 * (w / 100),
              ),
              constraints: BoxConstraints(
                maxWidth: 74.62 * (w / 100),
                minWidth: 14.92 * (w / 100),
              ),
              decoration: BoxDecoration(
                color: botMessagesModelMessages.role == 'user'
                    ? AppDarkColors.primaryColor
                    : Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : Colors.white,
                borderRadius: botMessagesModelMessages.role == 'user'
                    ? senderRadius
                    : receiverRadius,
              ),
              child: Text(
                botMessagesModelMessages.message ?? '',
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: botMessagesModelMessages.role == 'user'
                      ? Colors.white
                      : Get.find<AppController>().darkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            if (botMessagesModelMessages.role != 'user' &&
                botMessagesModelMessages.services?.isNotEmpty == true) ...{
              SizedBox(
                height: 2.48 * (w / 100),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      botMessagesModelMessages.services?.length ?? 0,
                      (index) {
                        return ServiceItem(
                          home: false,
                          onLikeService: () {},
                          onTapFreelancer: () {
                            Get.toNamed(AppRoutes.freelancerProfile,
                                arguments: {
                                  "id": botMessagesModelMessages
                                          .services?[index].user?.id ??
                                      0
                                });
                          },
                          onTapService: () {
                            Get.to(() => const ServiceDetailsScreen(),
                                arguments: {
                                  "id": botMessagesModelMessages
                                          .services?[index].id ??
                                      0
                                });
                          },
                          service: ServiceModel(
                            id: botMessagesModelMessages.services?[index].id,
                            subCategoryId: botMessagesModelMessages
                                .services?[index].subCategoryId,
                            cover:
                                botMessagesModelMessages.services?[index].cover,
                            isWishlist: botMessagesModelMessages
                                .services?[index].isWishlist,
                            title:
                                botMessagesModelMessages.services?[index].title,
                            description: botMessagesModelMessages
                                .services?[index].description,
                            rating: botMessagesModelMessages
                                .services?[index].rating,
                            isRecommended: botMessagesModelMessages
                                .services?[index].isRecommended,
                            startServiceFrom: botMessagesModelMessages
                                .services?[index].startServiceFrom,
                            user: UserModel(
                              id: botMessagesModelMessages
                                  .services?[index].user?.id,
                              username: botMessagesModelMessages
                                  .services?[index].user?.username,
                              name: botMessagesModelMessages
                                  .services?[index].user?.username,
                              profession: botMessagesModelMessages
                                  .services?[index].user?.profession,
                              avatar: botMessagesModelMessages
                                  .services?[index].user?.avatar,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
