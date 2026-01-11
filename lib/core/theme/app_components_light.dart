import 'package:flutter/material.dart';
import 'app_theme_light.dart';

class AppCardLight extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AppCardLight({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColorsLight.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColorsLight.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButtonLight extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const PrimaryButtonLight({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: Text(text),
    );
  }
}

class SecondaryButtonLight extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SecondaryButtonLight({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsLight.textSecondary,
        side: const BorderSide(color: AppColorsLight.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text),
    );
  }
}
