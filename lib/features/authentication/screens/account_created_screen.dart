import 'package:flutter/material.dart';
import 'package:gov_ease/core/app_routes.dart';
import 'package:gov_ease/features/authentication/widgets/custom_elevated_button.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // مربع الأيقونة
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.celebration_outlined,
                  size: 30,
                  color: Color(0xFF0F766E),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'تم إنشاء حسابك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16304F),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'أرسلنا رابط تفعيل إلى بريدك الإلكتروني. يمكنك البدء في تصفح الخدمات الآن.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 32),

              CustomElevatedButton(
                text: 'الانتقال إلى الرئيسية',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
