import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Widget? icon;
  final double? radius;
  final Color? bgColor;
  final Color? border;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.icon,
    this.bgColor,
    this.border,
    this.textColor,
    this.radius,
    this.fontSize,
    this.height,
    this.width,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius ?? getRadius(12)),
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: height ?? getHeight(60),
          width: width ?? double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? getRadius(12)),
            color: bgColor ?? AppColors.lightGreyColor,
            border: border != null ? Border.all(color: border!) : null,
          ),
          child: isLoading
              ? SizedBox(
            width: getWidth(24),
            height: getWidth(24),
            child: CircularProgressIndicator(
              color: AppColors.whiteColor,
              strokeWidth: 2.5,
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    color: textColor ?? AppColors.blackColor,
                  ),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.blackColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: icon),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}