import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gov_ease/core/app_routes.dart';
import 'package:gov_ease/features/authentication/data/auth_service.dart';
import 'package:gov_ease/features/authentication/widgets/auth_error_banner.dart';
import 'package:gov_ease/features/authentication/widgets/auth_header.dart';
import 'package:gov_ease/features/authentication/widgets/custom_elevated_button.dart';
import 'package:gov_ease/features/authentication/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  bool emailSent = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset({bool isResend = false}) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() => errorMessage = 'أدخل البريد الإلكتروني');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await AuthService().sendResetEmail(email);
      if (!mounted) return;
      setState(() => emailSent = true);
      if (isResend) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إعادة إرسال الرسالة')),
        );
      }
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
      body: SafeArea(child: emailSent ? _buildSentView() : _buildFormView()),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const AuthHeader(
              title: 'نسيت كلمة المرور؟',
              subTitle:
                  'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإنشاء كلمة مرور جديدة',
            ),

            const SizedBox(height: 16),

            if (errorMessage != null) ...[
              AuthErrorBanner(message: errorMessage!),
              const SizedBox(height: 16),
            ],

            CustomTextField(
              label: 'البريد الإلكتروني',
              hintText: 'name@example.com',
              controller: emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            CustomElevatedButton(
              text: 'إرسال رابط إعادة التعيين',
              onPressed: isLoading ? null : _sendReset,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFCCFBF1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 30,
              color: Color(0xFF0F766E),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'تحقق من بريدك',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16304F),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'إذا كان البريد ${emailController.text.trim()} مسجّلاً لدينا، '
            'فستصلك رسالة تحتوي على رابط لإعادة تعيين كلمة المرور خلال دقائق.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 32),

          CustomElevatedButton(
            text: 'العودة لتسجيل الدخول',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (r) => false,
              );
            },
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: isLoading ? null : () => _sendReset(isResend: true),
            child: const Text(
              'لم تصلك الرسالة؟ أعد الإرسال',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
