import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gov_ease/core/app_routes.dart';
import 'package:gov_ease/core/constants/app_colors.dart';
import 'package:gov_ease/features/authentication/data/auth_service.dart';
import 'package:gov_ease/features/authentication/widgets/auth_error_banner.dart';
import 'package:gov_ease/features/authentication/widgets/auth_header.dart';
import 'package:gov_ease/features/authentication/widgets/custom_elevated_button.dart';
import 'package:gov_ease/features/authentication/widgets/custom_text_field.dart';
import 'package:gov_ease/features/authentication/widgets/remember_me_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorMessage = 'أدخل البريد الإلكتروني وكلمة المرور');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await AuthService().login(email: email, password: password);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (r) => false);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = authErrorMessage(e));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const AuthHeader(),

                    const SizedBox(height: 32),

                    if (errorMessage != null) ...[
                      AuthErrorBanner(message: errorMessage!),
                      const SizedBox(height: 16),
                    ],

                    CustomTextField(
                      label: "البريد الإلكتروني",
                      hintText: "name@example.com",
                      controller: emailController,
                      icon: Icons.mail_outline_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      label: "كلمة المرور",
                      hintText: "Password",
                      controller: passwordController,
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                    ),

                    const SizedBox(height: 20),

                    RememberMeRow(
                      isChecked: isChecked,
                      onRememberChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      onForgotPasswordPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomElevatedButton(
                      text: 'تسجيل الدخول',
                      onPressed: isLoading ? null : _login,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: const Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.actionBlue,
                            ),
                          ),
                        ),
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
