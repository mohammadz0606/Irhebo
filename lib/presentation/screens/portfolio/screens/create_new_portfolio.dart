import 'dart:developer';

import '../../../../app/global_imports.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/upload_multiple_file.dart';

class CreateNewPortfolioScreen extends StatelessWidget {
  const CreateNewPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const NormalAppBar(
        title: "Crete Portfolio",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 4.97 * (w / 100),
            left: 4.97 * (w / 100),
            right: 4.97 * (w / 100),
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Create portfolio entries to showcase your work'.tr,
                  style: Get.textTheme.titleMedium,
                ),
              ),
              UploadMultipleFile(
                onFilesSelected: (file) {
                  log('DONE PIK FILE ${file.length}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
