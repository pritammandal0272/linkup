import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackbarFunction(
  BuildContext context,
  String text,
  Color colorValue,
  IconData iconMessage,
) {
  showTopSnackBar(
    Overlay.of(context),
    Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D1F38),

        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorValue, width: 2),
      ),
      child: Row(
        children: [
          Icon(iconMessage, color: colorValue, size: 28),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                // : Colors.black87,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    ),
    animationDuration: const Duration(
      milliseconds: 800,
    ), // Slower, smoother entrance
    displayDuration: const Duration(seconds: 2),
    curve: Curves.elasticOut,
  );
}
