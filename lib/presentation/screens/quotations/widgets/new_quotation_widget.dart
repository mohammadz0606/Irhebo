import '../../../../app/global_imports.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';
import '../../../widgets/app_image.dart';

class NewQuotationWidget extends StatelessWidget {
  const NewQuotationWidget({
    super.key,
    this.data,
  });

  final FreelancerHomeModelDataQuotations? data;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: AppDecoration.getDecorationWithRadius(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.darkContainer2
              : AppLightColors.pureWhite,
          radius: 12),
      margin: EdgeInsets.symmetric(vertical: 1.99 * (w / 100)),
      padding: EdgeInsets.symmetric(
          horizontal: 4.49 * (w / 100), vertical: 3.48 * (w / 100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.title ?? '',
            style: Get.theme.textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            data?.description ?? "",
            style: Get.theme.textTheme.labelMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.97 * (w / 100),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppImage(
                    imageUrl: data?.user?.avatar ?? "",
                    width: 7.46 * (w / 100),
                    height: 7.46 * (w / 100),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 2.73 * (w / 100),
                  ),
                  Text(
                    data?.user?.username ?? "",
                    style: Get.theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text(
                data?.createdAt ?? "",
                style: Get.theme.textTheme.labelMedium!
                    .copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
