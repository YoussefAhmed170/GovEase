import 'package:flutter/material.dart';
import 'package:gov_ease/features/authentication/widgets/auth_header.dart';
import 'package:gov_ease/features/authentication/widgets/custom_elevated_button.dart';
import 'package:gov_ease/features/authentication/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AuthHeader(
                  title: 'نسيت كلمة المرور؟',
                  subTitle:
                      'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإنشاء كلمة مرور جديدة',
                ),

                SizedBox(height: 16),

                CustomTextField(
                  label: 'البريد الإلكتروني',
                  hintText: 'name@example.com',
                  icon: Icons.email_outlined,
                ),

                SizedBox(height: 16),

                CustomElevatedButton(
                  text: 'إرسال رابط إعادة التعيين',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
