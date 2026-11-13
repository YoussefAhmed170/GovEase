import 'package:flutter/material.dart';
import 'package:gov_ease/features/authentication/screens/account_created_screen.dart';
import 'package:gov_ease/features/authentication/screens/forgot_password_screen.dart';
import 'package:gov_ease/features/authentication/screens/login_screen.dart';
import 'package:gov_ease/features/authentication/screens/register_screen.dart';
import 'package:gov_ease/features/authentication/screens/splash_screen.dart';

class AppRoutes {
  // (Auth)
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String accountCreated = '/account-created';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  //(home & services & branches)
  static const String home = '/home';
  static const String servicesCatalog = '/services-Catalog';
  static const String serviceDetails = '/service-details';
  static const String branchDiscovery = '/branches-discovery';
  static const String branchDetails = '/branch-details';

  static const String notifications = '/notifications';
  static const String profile = '/profile';

  // (Bookings)
  static const String booking = '/booking';
  static const String ticketConfirmation = '/ticket-confirmation';
  static const String appointmentConfirmation = '/appointment-confirmation';
  static const String myBookings = '/my-bookings';
  static const String ticketTracking = '/ticket-tracking';
  static const String appointmentDetails = '/appointment-details';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    accountCreated: (context) => const AccountCreatedScreen(),
  };
}
