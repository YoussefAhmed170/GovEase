import 'package:flutter/material.dart';
import 'package:gov_ease/core/constants/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/GovEase.png',
          width: 52,
          height: 52,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),

        const Text(
          'مرحباً بعودتك',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),

        const Text(
          'سجّل الدخول لمتابعة حجوزاتك وخدماتك.',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColors.textHint,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
