import 'package:core_kit/core_kit_internal.dart';
import 'package:cubit_template/config/color/app_color.dart';
import 'package:flutter/material.dart';

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16.w),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Flag
            ClipRRect(
              borderRadius: BorderRadius.circular(6.w),
              child: SizedBox(
                width: 42.w,
                height: 32.h,
                child: Image.asset(
                  flagAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CkText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    textColor: isSelected ? Colors.white : Colors.black,
                  ),
                  4.height,
                  CkText(
                    text: subtitle,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    textColor: isSelected
                        ? Colors.white.withValues(alpha: 0.7)
                        : Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            // Solid Beige Circle with Checkmark
            Container(
              width: 26.w,
              height: 26.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFD4B483) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFFD4B483) : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.black,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
