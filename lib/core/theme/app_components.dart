import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_theme_light.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.border
              : AppColorsLight.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.6)
                : Colors.black.withOpacity(0.06),
            blurRadius: Theme.of(context).brightness == Brightness.dark ? 20 : 24,
            offset: Offset(0, Theme.of(context).brightness == Brightness.dark ? 10 : 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const PrimaryButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SecondaryButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.textSecondary 
            : AppColorsLight.textSecondary,
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.border 
              : AppColorsLight.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text),
    );
  }
}
