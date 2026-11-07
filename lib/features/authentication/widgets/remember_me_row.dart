import 'package:flutter/material.dart';
import 'package:gov_ease/core/constants/app_colors.dart';

class RememberMeRow extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotPasswordPressed;

  const RememberMeRow({
    super.key,
    required this.isChecked,
    required this.onRememberChanged,
    required this.onForgotPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onForgotPasswordPressed,
          child: const Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.actionBlue,
            ),
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'تذكرني',
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
                onChanged: onRememberChanged,
                activeColor: const Color(0xFF2563EB),
                side: const BorderSide(color: Color(0xFF9CA3AF), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
