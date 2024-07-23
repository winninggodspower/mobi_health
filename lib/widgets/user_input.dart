import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textInput;
  final String hintText;
  final Color inputColor, borderColor;
  const TextInput({
    super.key,
    required this.textInput,
    required this.hintText,
    required this.inputColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: textInput,
        focusNode: FocusNode(),
        keyboardType: TextInputType.text,
        style: textStyle,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle,
          filled: true,
          fillColor: AppColors.grayLight,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.gray, width: 1.2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.gray, width: 1.2)),
        ),
      ),
    );
  }
}
