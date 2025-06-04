import 'package:irhebo/presentation/screens/profile/widgets/profile_header.dart';
import 'package:irhebo/presentation/screens/profile/widgets/profile_shimmer.dart';
import 'package:irhebo/presentation/screens/profile/widgets/user_info_widget.dart';

import '../../../app/global_imports.dart';
import '../../../domain/providers/freelancer/freelancer_profile.dart';
import '../../widgets/normal_app_bar.dart';

class FreelancerProfileScreen extends StatefulWidget {
  const FreelancerProfileScreen({super.key});

  @override
  State<FreelancerProfileScreen> createState() =>
      _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  @override
  void initState() {
    Provider.of<FreelancerProfileProvider>(context, listen: false)
        .getFreelancerProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const NormalAppBar(
        title: "Profile",
      ),
      body: Consumer<FreelancerProfileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 1 * (w / 100),
              horizontal: 4.47 * (w / 100),
            ),
            child: provider.isLoading ? const ProfileShimmer() : Column(

              children: [
                // ProfileHeader(
                //   loading: controller.isLoadingUpdate,
                //   updatePicture: () => controller
                //       .updateProfileButton(forPicture: true),
                //   path: controller.imagePath,
                //   user: controller.user,
                //   pickPicture: controller.pickPicture,
                // ),
                // UserInfoWidget(
                //   user: controller.user,
                //   goToUpdate: controller.goToUpdate,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
