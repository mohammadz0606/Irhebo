import 'package:get/get.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_notifications_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/read_notification_use_case.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationsController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool _isLoading = true.obs;
  final RxInt _pageNumber = 1.obs;

  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;

  // ignore: invalid_use_of_protected_member
  List<NotificationModel> get notifications => _notifications.value;
  int get pageNumber => _pageNumber.value;
  bool get isLoading => _isLoading.value;

  set notifications(value) => _notifications.value = value;
  set isLoading(value) => _isLoading.value = value;
  set pageNumber(value) => _pageNumber.value = value;

  @override
  onInit() async {
    super.onInit();

    await getNotifications();
    isLoading = false;
  }

  onRefreshList() async {
    isLoading = true;
    pageNumber = 1;
    notifications.clear();
    await getNotifications();
    isLoading = false;
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  getNotifications() async {
    GetNotificationsUseCase getNotificationsUseCase = sl();
    final result = await getNotificationsUseCase(PaginationParams(
      page: pageNumber,
      perPage: AppConstants.PAGE_LENGTH,
    ));
    result!.fold((l) {
      refreshController.refreshFailed();
    }, (r) {
      // if (pageNumber == 1) {
      //   notifications.clear();
      // }
      pageNumber = pageNumber + 1;
      notifications.addAll(r.data?.notifications ?? []);
      if (r.data!.notifications!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _notifications.refresh();
    });
  }

  readNotificationById(int id) async {
    ReadNotificationUseCase readNotificationUseCase = sl();
    final result = await readNotificationUseCase(id);
    result!.fold((l) {}, (r) {});
  }

  receiveParameters() {}
}
