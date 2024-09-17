import 'package:flutter/services.dart';

import '../../shared.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield(
      {super.key,
      required this.controller,
      this.icon,
      required this.title,
      this.keyboardType,
      this.horizontalPadding,
      this.maxlines,
      this.height,
      this.secondIcon,
      this.onIconTap,
      this.onSecondIconTap,
      this.obscureText = false,
      this.textInputAction,
      this.onSubmitted,
      this.maxLength,
      this.hintText,
      this.focusColor,
      this.enableInteractiveSelection,
      this.onChanged,
      this.prefixText,
      this.textColor,
      this.readOnly,
      this.onTap,
      this.inputFormatters});

  final TextEditingController controller;
  final dynamic icon;
  final IconData? secondIcon;
  final String title;
  final String? hintText;
  final String? prefixText;
  final bool? enableInteractiveSelection;
  final double? horizontalPadding;
  final VoidCallback? onIconTap;
  final void Function()? onTap;
  final VoidCallback? onSecondIconTap;
  final TextInputType? keyboardType;
  final int? maxlines;
  final double? height;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final int? maxLength;
  final bool? readOnly;
  final Color? focusColor;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: inputFormatters,
        readOnly: readOnly ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        maxLines: maxlines,
        decoration: InputDecoration(
          focusColor: Colors.white,
          prefixText: prefixText,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,
          labelText: title,
          labelStyle: const TextStyle(
            decorationStyle: TextDecorationStyle.dotted,
            color: Colors.blueGrey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
