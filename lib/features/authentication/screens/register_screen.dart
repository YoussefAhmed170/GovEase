import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gov_ease/core/app_routes.dart';
import 'package:gov_ease/core/constants/app_colors.dart';
import 'package:gov_ease/features/authentication/data/auth_service.dart';
import 'package:gov_ease/features/authentication/widgets/auth_error_banner.dart';
import 'package:gov_ease/features/authentication/widgets/auth_header.dart';
import 'package:gov_ease/features/authentication/widgets/custom_elevated_button.dart';
import 'package:gov_ease/features/authentication/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isChecked = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    setState(() => errorMessage = message);
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _register() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = passwordConfirmationController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showError('أكمل جميع الحقول');
      return;
    }
    if (password.length < 8) {
      _showError('كلمة المرور يجب أن تكون 8 أحرف على الأقل');
      return;
    }
    if (password != confirm) {
      _showError('كلمتا المرور غير متطابقتين');
      return;
    }
    if (!isChecked) {
      _showError('يجب الموافقة على شروط الاستخدام وسياسة الخصوصية');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await AuthService().register(
        fullName: name,
        email: email,
        password: password,
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.accountCreated,
        (r) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showError(authErrorMessage(e));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const AuthHeader(
                  title: 'إنشاء حساب جديد',
                  subTitle: 'حساب واحد لكل خدماتك وحجوزاتك',
                ),
                const SizedBox(height: 32),

                if (errorMessage != null) ...[
                  AuthErrorBanner(message: errorMessage!),
                  const SizedBox(height: 16),
                ],

                CustomTextField(
                  label: 'الاسم كامل',
                  hintText: 'مثال: سارة الخطيب',
                  controller: fullNameController,
                  icon: Icons.person,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'البريد الإلكتروني',
                  hintText: 'name@example.com',
                  controller: emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'كلمة المرور',
                  hintText: '',
                  controller: passwordController,
                  icon: Icons.lock_outline_rounded,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 8),
                const Text(
                  '.\u200F8 أحرف على الأقل، ويُفضّل أن تتضمن رقماً',
                  style: TextStyle(color: AppColors.textHint),
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'تأكيد كلمة المرور',
                  hintText: '',
                  controller: passwordConfirmationController,
                  icon: Icons.lock_outline_rounded,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'أوافق علي شروط الاستخدام وسياسة الخصوصية',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF2563EB),
                        side: const BorderSide(
                          color: Color(0xFF9CA3AF),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                CustomElevatedButton(
                  text: 'إنشاء الحساب',
                  onPressed: isLoading ? null : _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
