import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_tickets_use_case.dart';

class SupportTicketsController extends GetxController {
  List<TicketModel> tickets = [];

  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  onInit() async {
    super.onInit();
    await getTickets();
  }

  getTickets() async {
    isLoading = true;

    GetTicketsUseCase getTicketsUseCase = sl();
    final result = await getTicketsUseCase(());
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      tickets = r.data ?? [];
      isLoading = false;
    });
  }

  onTapTicket(int i) async {
    await Get.toNamed(AppRoutes.ticketDetails,
        arguments: {"id": tickets[i].id, "ticket": tickets[i]})?.then(
      (value) => getTickets(),
    );
  }
}
