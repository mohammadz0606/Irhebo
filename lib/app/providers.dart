import 'package:provider/single_child_widget.dart';

import '../domain/providers/freelancer/complete_profile.dart';
import '../domain/providers/upload_files.dart';
import '../domain/providers/freelancer/freelancer_services.dart';
import 'global_imports.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UploadFilesProvider()),
  ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerServicesProvider()),
];
