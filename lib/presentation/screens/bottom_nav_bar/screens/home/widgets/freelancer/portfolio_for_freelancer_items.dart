import '../../../../../../../app/global_imports.dart';
import '../../../../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../../../../widgets/app_image.dart';
import 'edit_or_delete.dart';

class PortfolioForFreelancerItems extends StatelessWidget {
  const PortfolioForFreelancerItems({
    super.key,
    required this.data,
  });

  final FreelancerHomeModelDataPortfolios? data;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 12,
      ),
      decoration: Get.find<AppController>().darkMode
          ? null
          : AppDecoration.getDecorationWithShadow(radius: 18),
      child: Stack(
        children: [
          AppImage(
            imageUrl: data?.cover?.mediaPath ?? '',
            width: 41 * (w / 100),
            height: 51 * (w / 100),
            radius: 25,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 41 * (w / 100),
              padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppLightColors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                data?.title ?? '',
                style: Get.theme.textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: 2.98 * (w / 100),
            right: 2.98 * (w / 100),
            child: EditOrDelete(
              id: data?.id ?? 0,
              space: 19.2,
            ),
          ),
        ],
      ),
    );
  }
}
