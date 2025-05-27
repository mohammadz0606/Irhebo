import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/domain/models/request_model.dart';

class RequestHistoryController extends GetxController {
  final RxList<LogModel> _logs = <LogModel>[].obs;
  RxMap<String, List<LogModel>> groupedLogs = <String, List<LogModel>>{}.obs;
  List<LogModel> get logs => _logs;
  set logs(List<LogModel> value) {
    _logs.value = value;
    groupLogs();
  }

  onTapBack() {
    Get.back();
  }

  void groupLogs() {
    Map<String, List<LogModel>> grouped = {};
    _logs.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    for (var log in _logs) {
      String formattedDate = formatDate(DateTime.parse(log.createdAt!));
      grouped.putIfAbsent(formattedDate, () => []).add(log);
    }
    groupedLogs.value = grouped; // Assign to reactive map
  }

  @override
  void onInit() {
    super.onInit();
    receiveParameters();
    groupLogs();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      logs = Get.arguments["logs"] ?? 0;
    }
  }
}
