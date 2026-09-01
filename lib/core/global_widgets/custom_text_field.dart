import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final bool? readOnly;
  final void Function()? onTap;
  final ValueChanged<String>? onChanged;
  final bool obSecureText;
  final TextInputType? textInputType;
  final String? errorText;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.obSecureText = false,
    this.textInputType,
    this.height,
    this.radius,
    this.borderColor,
    this.readOnly,
    this.onTap,
    this.errorText,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: maxLines != null && maxLines! > 1
                  ? null
                  : (height ?? getHeight(57)),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError
                  ? Colors.red
                  : (borderColor ?? Colors.grey),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius ?? getRadius(12)),
          ),
          child: TextField(
            onTap: onTap,
            autofocus: false,
            controller: controller,
            obscureText: obSecureText,
            keyboardType: textInputType,
            onChanged: onChanged,
            readOnly: readOnly ?? false,
            cursorColor: Colors.grey,
            maxLines: maxLines ?? 1,
            enableInteractiveSelection: true,
            style: globalTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: isDark
                     ? AppColors.whiteColor
                     : AppColors.blackColor,
            ),
            decoration: InputDecoration(
              hintText: hinText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              filled: true,
                fillColor: isDark
                           ? Colors.transparent
                           : Color(0xFFF7F8F8),
              hintStyle: globalTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(getRadius(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError
                    ? Colors.transparent
                    : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(getRadius(12)),
              ),
              border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getWidth(16),
                  vertical: getHeight(14),
                )
            ),
          ),
        ),
        // Error message outside the border
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 6),
            child: Text(
              errorText!,
              style: globalTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}