import 'package:flutter/material.dart';
import 'package:gov_ease/core/constants/app_colors.dart';
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

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AuthHeader(),
              SizedBox(height: 32),
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
              Text(
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

              SizedBox(height: 8),

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

              SizedBox(height: 16),

              CustomElevatedButton(text: 'إنشاء الحساب', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
