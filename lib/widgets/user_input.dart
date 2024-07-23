import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first


class TextInput extends StatelessWidget {
 final TextEditingController textInput;
  final String hintText;
  final Color inputColor, borderColor;
  final TextInputType textType;

  const TextInput({
    Key? key,
    required this.textInput,
    required this.hintText,
    required this.inputColor,
    required this.borderColor,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: textInput,
        focusNode: FocusNode(),
        keyboardType: textType,
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
