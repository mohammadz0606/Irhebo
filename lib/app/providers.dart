import 'package:provider/single_child_widget.dart';

import '../domain/providers/chat/chat_provider.dart';
import '../domain/providers/currency.dart';
import '../domain/providers/freelancer/complete_profile.dart';
import '../domain/providers/freelancer/freelancer_portfolio.dart';
import '../domain/providers/freelancer/freelancer_profile.dart';
import '../domain/providers/files_manager.dart';
import '../domain/providers/freelancer/freelancer_services.dart';
import '../domain/providers/freelancer/service.dart';
import '../domain/providers/media.dart';
import '../domain/providers/notification.dart';
import '../domain/providers/social_auth.dart';
import 'global_imports.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => FilesManagerProvider()),
  ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerServicesProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerPortfolioProvider()),
  ChangeNotifierProvider(create: (_) => FreelancerProfileProvider()),
  ChangeNotifierProvider(create: (_) => CurrencyProvider()),
  ChangeNotifierProvider(create: (_) => ServiceProvider()),
  ChangeNotifierProvider(create: (_) => MediaProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ChangeNotifierProvider(create: (_) => ChatProvider()),
  ChangeNotifierProvider(create: (_) => SocialAuthProvider()),
];
