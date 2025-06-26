import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/auth/verification/verification_freelancer.dart';
import 'package:irhebo/presentation/screens/faqs/faqs_binding.dart';
import 'package:irhebo/presentation/screens/faqs/faqs_screen.dart';
import 'package:irhebo/presentation/screens/portfolio/screens/my_portfolio.dart';
import 'package:irhebo/presentation/screens/privacy_policy/privacy_policy_binding.dart';
import 'package:irhebo/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:irhebo/presentation/screens/profile/profile_binding.dart';
import 'package:irhebo/presentation/screens/profile/profile_screen.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_binding.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_screen.dart';
import 'package:irhebo/presentation/screens/support_tickets/support_tickets_binding.dart';
import 'package:irhebo/presentation/screens/support_tickets/support_tickets_screen.dart';
import 'package:irhebo/presentation/screens/terms_conditions/terms_conditions_binding.dart';
import 'package:irhebo/presentation/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_binding.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_screen.dart';
import 'package:irhebo/presentation/screens/create_ticket/create_ticket_binding.dart';
import 'package:irhebo/presentation/screens/create_ticket/create_ticket_screen.dart';
import 'package:irhebo/presentation/screens/auth/create_password/create_password_binding.dart';
import 'package:irhebo/presentation/screens/auth/create_password/create_password_screen.dart';
import 'package:irhebo/presentation/screens/auth/forget_password/forget_password_binding.dart';
import 'package:irhebo/presentation/screens/auth/forget_password/forget_password_screen.dart';
import 'package:irhebo/presentation/screens/auth/login/login_binding.dart';
import 'package:irhebo/presentation/screens/auth/login/login_screen.dart';
import 'package:irhebo/presentation/screens/auth/register/register_binding.dart';
import 'package:irhebo/presentation/screens/auth/register/register_screen.dart';
import 'package:irhebo/presentation/screens/auth/verification/verification_binding.dart';
import 'package:irhebo/presentation/screens/auth/verification/verification_screen.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_binding.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:irhebo/presentation/screens/chat/chat_binding.dart';
import 'package:irhebo/presentation/screens/chat/chat_screen.dart';
import 'package:irhebo/presentation/screens/checkout/checkout_binding.dart';
import 'package:irhebo/presentation/screens/checkout/checkout_screen.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/freelancer_profile_binding.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/freelancer_profile_screen.dart';
import 'package:irhebo/presentation/screens/gallery/gallery_binding.dart';
import 'package:irhebo/presentation/screens/gallery/gallery_screen.dart';
import 'package:irhebo/presentation/screens/intro/splash_binding.dart';
import 'package:irhebo/presentation/screens/intro/splash_screen.dart';
import 'package:irhebo/presentation/screens/notifications/notifications_binding.dart';
import 'package:irhebo/presentation/screens/notifications/notifications_screen.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_binding.dart';
import 'package:irhebo/presentation/screens/portfolio_details/portfolio_details_screen.dart';
import 'package:irhebo/presentation/screens/quotation_details/quotation_details_binding.dart';
import 'package:irhebo/presentation/screens/quotation_details/quotation_details_screen.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_binding.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_screen.dart';
import 'package:irhebo/presentation/screens/request_history/request_history_binding.dart';
import 'package:irhebo/presentation/screens/request_history/request_history_screen.dart';
import 'package:irhebo/presentation/screens/search/search_binding.dart';
import 'package:irhebo/presentation/screens/search/search_screen.dart';
import 'package:irhebo/presentation/screens/see_all/see_All_screen.dart';
import 'package:irhebo/presentation/screens/see_all/see_all_binding.dart';
import 'package:irhebo/presentation/screens/ticket_details/ticket_details_binding.dart';
import 'package:irhebo/presentation/screens/ticket_details/ticket_details_screen.dart';

import '../../presentation/screens/auth/register/register_freelancer_screen.dart';
import '../../presentation/screens/chat/call_screen.dart';
import '../../presentation/screens/freelancer_services/screens/all_freelancer_services.dart';
import '../../presentation/screens/freelancer_services/screens/create_plan.dart';
import '../../presentation/screens/freelancer_services/screens/create_services.dart';
import '../../presentation/screens/portfolio/screens/create_new_update_portfolio.dart';

class AppScreens {
  static List<GetPage> screens = <GetPage>[
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.search,
        page: () => const SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: AppRoutes.notifications,
        page: () => const NotificationsScreen(),
        binding: NotificationsBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.register,
        page: () => const RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.verification,
        page: () => const VerificationScreen(),
        binding: VerificationBinding()),
    GetPage(
        name: AppRoutes.createPassword,
        page: () => const CreatePasswordScreen(),
        binding: CreatePasswordBinding()),
    GetPage(
        name: AppRoutes.forgetPassword,
        page: () => const ForgetPasswordScreen(),
        binding: ForgetPasswordBinding()),
    GetPage(
        name: AppRoutes.gallery,
        page: () => const GalleryScreen(),
        binding: GalleryBinding()),
    // GetPage(
    //     name: AppRoutes.servicesDetails,
    //     page: () => const ServiceDetailsScreen(),
    //     binding: ServiceDetailsBinding()),
    GetPage(
        name: AppRoutes.freelancerProfile,
        page: () => const FreelancerProfileScreen(),
        binding: FreelancerProfileBinding()),
    GetPage(
        name: AppRoutes.chat,
        page: () => const ChatScreen(),
        binding: ChatBinding()),
    // GetPage(
    //     name: AppRoutes.wishlist,
    //     page: () => const WishlistScreen(),
    //     binding: WishlistBinding()),
    GetPage(
        name: AppRoutes.requestDetails,
        page: () => const RequestDetailsScreen(),
        binding: RequestDetailsBinding()),
    GetPage(
        name: AppRoutes.createTicket,
        page: () => const CreateTicketScreen(),
        binding: CreateTicketBinding()),
    GetPage(
        name: AppRoutes.ticketDetails,
        page: () => const TicketDetailsScreen(),
        binding: TicketDetailsBinding()),
    GetPage(
        name: AppRoutes.bottomNavBar,
        page: () => const BottomNavBarScreen(),
        binding: BottomNavBarBinding()),
    GetPage(
      name: AppRoutes.registerFreelancer,
      page: () => const RegisterFreelancerScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
        name: AppRoutes.seeAll,
        page: () => const SeeAllScreen(),
        binding: SeeAllBinding()),
    GetPage(
        name: AppRoutes.checkout,
        page: () => const CheckoutScreen(),
        binding: CheckoutBinding()),
    GetPage(
        name: AppRoutes.requestHistory,
        page: () => const RequestHistoryScreen(),
        binding: RequestHistoryBinding()),
    GetPage(
        name: AppRoutes.portfolioDetails,
        page: () => const PortfolioDetailsScreen(),
        binding: PortfolioDetailsBinding()),
    // GetPage(
    //     name: AppRoutes.home,
    //     page: () => const HomeScreen(),
    //     binding: HomeBinding()),
    // GetPage(
    //     name: AppRoutes.requests,
    //     page: () => const RequestsScreen(),
    //     binding: RequestsBinding()),
    // GetPage(
    //     name: AppRoutes.wishlist,
    //     page: () => const WishlistScreen(),
    //     binding: WishlistBinding()),
    // GetPage(
    //     name: AppRoutes.settings,
    //     page: () => const SettingsScreen(),
    //     binding: SettingsBinding()),
    // GetPage(
    //     name: AppRoutes.allChats,
    //     page: () => const AllChatsScreen(),
    //     binding: AllChatsBinding()),
    GetPage(
        name: AppRoutes.quotationDetails,
        page: () => const QuotationDetailsScreen(),
        binding: QuotationDetailsBinding()),
    GetPage(
        name: AppRoutes.faqs,
        page: () => const FaqsScreen(),
        binding: FaqsBinding()),
    GetPage(
        name: AppRoutes.profile,
        page: () => const ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: AppRoutes.supportTickets,
        page: () => const SupportTicketsScreen(),
        binding: SupportTicketsBinding()),
    GetPage(
        name: AppRoutes.createQuotation,
        page: () => const CreateQuotationScreen(),
        binding: CreateQuotationBinding()),
    GetPage(
        name: AppRoutes.quotations,
        page: () => const QuotationsScreen(),
        binding: QuotationsBinding()),
    GetPage(
        name: AppRoutes.privacyPolicy,
        page: () => const PrivacyPolicyScreen(),
        binding: PrivacyPolicyBinding()),
    GetPage(
        name: AppRoutes.termsConditions,
        page: () => const TermsConditionsScreen(),
        binding: TermsConditionsBinding()),
    GetPage(
      name: AppRoutes.termsConditions,
      page: () => const CreateNewUpdatePortfolioScreen(),
    ),

    GetPage(
      name: AppRoutes.myPortfolio,
      page: () => const MyPortfolioScreen(),
    ),

    GetPage(
      name: AppRoutes.createUpdatePortfolio,
      page: () => const CreateNewUpdatePortfolioScreen(),
    ),
    GetPage(
      name: AppRoutes.myServices,
      page: () => const AllFreelancerServices(),
    ),

    GetPage(
      name: AppRoutes.createService,
      page: () => const CreateServicesScreen(),
    ),
    GetPage(
      name: AppRoutes.vrificationFreelancerScreen,
      page: () => const VerificationFreelancerScreen(),
    ),
    GetPage(
      name: AppRoutes.createPlan,
      page: () => const CreatePlanScreen(),
    ),
    GetPage(
      name: AppRoutes.call,
      page: () => const CallScreen(),
    ),
  ];
}
