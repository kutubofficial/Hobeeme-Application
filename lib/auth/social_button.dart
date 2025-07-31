import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onPressed;

  const SocialLoginButton({super.key, required this.assetPath, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[800]!, width: 1),
        ),
        child: Image.asset(
          assetPath,
          height: 24,
          width: 24,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red);
          },
        ),
      ),
    );
  }
}
