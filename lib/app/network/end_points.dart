// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';

import '../injection.dart';
import '../storage/app_prefs.dart';

class AppEndpoints {
  AppPreferences prefs = sl();

  ///LOCAL
  // static String base_url = 'https://irhebo-backend.smartedge.me/api/v1';

  ///STORE
  static String base_url = !kDebugMode
      ? 'https://irhebo-backend.smartedge.me/api/v1'
      : 'https://irhebo-back.smartedge.me/api/v1';

  static String media_url = kDebugMode
      ? 'https://irhebo-back.smartedge.me/'
      : 'https://irhebo-back.smartedge.me/';

  static String login = '$base_url/login';
  static String logout = '$base_url/auth/logout';
  static String home = '$base_url/home';
  static String services = '$base_url/services/';
  static String servicesByUser = '$base_url/services/get-by-user';
  static String wishlist = '$base_url/wishlist';
  static String filters = '$base_url/filters/';
  static String checkout = '$base_url/checkout/proceed';
  static String requests = '$base_url/requests/';
  static String updateRequest = '$base_url/requests/add-comment';
  static String portfolios = '$base_url/portfolio/featured';
  static String freelancerProfile = '$base_url/users/freelancer-profile/';
  static String changePassword = '$base_url/users/change-password';
  static String requestDetails = '$base_url/requests/details/';
  static String notifications = '$base_url/notifications/';
  static String faqs = '$base_url/faqs/';
  static String tickets = '$base_url/tickets/';
  static String applyFilter = '$base_url/filters/apply';
  static String quotations = '$base_url/quotations/get-by-user-id';
  static String quotationsForFreelance =
      '$base_url/quotations/get-by-freelancer-id';
  static String quotationDetails = '$base_url/quotations/details/';
  static String createQuotationComment = '$base_url/quotations/create-comment';
  static String quotationCommentList = '$base_url/quotations/comment-list/';
  static String createQuotation = '$base_url/quotations/create';
  static String updateProfile = '$base_url/users/update-profile';
  static String createTicket = '$base_url/tickets/submit-ticket';
  static String closeTicket = '$base_url/tickets/close-ticket/';
  static String addTicketResponse = '$base_url/tickets/add-response';
  static String readNotification = '$base_url/notifications/read/';
  static String toggleFav = '$base_url/wishlist/toggle';
  static String createRequest = '$base_url/requests/create';
  static String review = '$base_url/submit-review';
  static String searchServices = '$base_url/services/search';
  static String categories = '$base_url/categories/';
  static String freelancerCategories = '$base_url/users/freelancer-categories';
  static String subcategories = '$base_url/sub-categories/';
  static String serivceDetails = '$base_url/services/details/';
  static String portfolioDetails = '$base_url/portfolio/details/';
  static String verifyCode = '$base_url/verify-code';
  static String resetPassword = '$base_url/reset-password';
  static String register = '$base_url/register';
  static String general = '$base_url/shared/general-data';
  static String config = '$base_url/shared/register-data';
  static String steps = '$base_url/sliders';
  static String myProfile = '$base_url/users/client-profile';
  static String requestCode = '$base_url/generate-code';
  static String completeProfile = '$base_url/users/complete-profile';
  static String homeFreelancer = '$base_url/home-freelancer';
  static String createPortfolio = '$base_url/portfolio/create';
  static String getFreelancerProfile = '$base_url/users/freelancer-profile/';
  static String getPortfolioUser = '$base_url/users/portfolio';
  static String getPortfolio = '$base_url/portfolio';
  static String updatePortfolio = '$base_url/portfolio/update/';
  static String deletePortfolio = '$base_url/portfolio/delete/';
  static String verifyAccount = '$base_url/users/verify';
  static String confirmRequest = '$base_url/requests/confirm-request/';
  static String approveQuotation = '$base_url/quotations/approve-quotation/';
  static String currencies = '$base_url/currencies';
  static String tags = '$base_url/tags/by_sub_category/';
  static String plans = '$base_url/shared/plans';
  static String createService = '$base_url/services/create';
  static String deleteMedia = '$base_url/services/delete-media/';

  static String changeNotifiable = '$base_url/notifications/change-notifiable';
  static String markAsRead = '$base_url/notifications/mark-as-read/';
  static String socialLogin = '$base_url/social-login';

  ///CHAT
  static String startChat = '$base_url/chat/start-chat?user_id=';
  static String getChatList = '$base_url/chat/get-chat';
  static String sendMessage = '$base_url/chat/send-message';
  static String getMessages = '$base_url/chat/get-messages/';
  static String markRead = '$base_url/chat/mark-read/';
  static String toggleChat = '$base_url/chat/toggle-flag';
}
