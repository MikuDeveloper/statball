import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:statball/app/config/themes/app_colors.dart';

class SbSubmitButton extends StatelessWidget {
  const SbSubmitButton({
    super.key,
    required this.onSubmit,
    required this.text,
    this.icon,
    this.isLoading = false,
  });

  final VoidCallback onSubmit;
  final String text;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        final isValid = form.valid;

        return MouseRegion(
          cursor: isLoading
              ? SystemMouseCursors.progress
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: isLoading ? null : onSubmit,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: _buildDecoration(isValid: isValid),
              child: _buildButtonContent(context, isValid: isValid),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonContent(BuildContext context, {required bool isValid}) {
    return Center(
      child: isLoading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: isValid ? AppColors.bgDark : AppColors.accent,
              ),
            )
          : Row(
              spacing: 12,
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              children: [
                Text(
                  text,
                  // style: TextStyle(
                  //   color: isValid ? AppColors.bgDisabled : AppColors.textMuted,
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w700,
                  //   letterSpacing: 0.3,
                  // ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isValid ? AppColors.bgDisabled : AppColors.textMuted,
                    letterSpacing: 0.3,
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    size: 17,
                    color: isValid ? AppColors.bgDark : AppColors.textMuted,
                  ),
              ],
            ),
    );
  }

  BoxDecoration _buildDecoration({required bool isValid}) {
    return BoxDecoration(
      gradient: isValid
          ? const LinearGradient(
              colors: [AppColors.accent, Color(0xFF00C98A)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: isValid ? null : AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      border: isValid
          ? null
          : Border.all(color: AppColors.inputBorder, width: 1),
      boxShadow: isValid
          ? [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ]
          : null,
    );
  }
}
