import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      onChanged: onChanged,
      obscureText: obscureText, // 비밀번호 입력시 사용
      autocorrect: autoFocus,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
