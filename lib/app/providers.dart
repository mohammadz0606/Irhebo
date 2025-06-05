import 'package:provider/single_child_widget.dart';

import '../domain/providers/currency.dart';
import '../domain/providers/freelancer/complete_profile.dart';
import '../domain/providers/freelancer/freelancer_portfolio.dart';
import '../domain/providers/freelancer/freelancer_profile.dart';
import '../domain/providers/files_manager.dart';
import '../domain/providers/freelancer/freelancer_services.dart';
import 'global_imports.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => FilesManagerProvider()),
  ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerServicesProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerPortfolioProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerProfileProvider()),
  ChangeNotifierProvider(create: (_) => CurrencyProvider()),
];
