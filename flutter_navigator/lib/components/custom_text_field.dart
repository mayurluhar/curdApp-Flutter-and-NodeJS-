import 'package:flutter/material.dart';
import 'package:flutter_navigator/utils/constant.dart';

class EditText extends StatelessWidget {
  final Color focusedBorderColor;
  final Color hintcColor;
  final String hintText;
  final double borderRadius;
  final double borderWidth;
  final Color fillColor;
  final bool password;
  final TextEditingController textController;
  final int maxLines;
  final Function onTap;
  final bool readOnly;
  final TextInputType keyBoardType;
  final TextInputAction inputAction;

  EditText(
      {required this.focusedBorderColor,
        required this.hintcColor,
      required this.borderRadius,
      required this.hintText,
      required this.fillColor,
      required this.borderWidth,
      required this.textController,
      required this.password,
      required this.maxLines,
      required this.onTap,
      required this.readOnly,
      required this.keyBoardType,
      required this.inputAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: password,
        controller: textController,
        maxLines: maxLines,
        onTap: () {
          onTap();
        },
        textAlign: TextAlign.start,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        textInputAction: inputAction,
        style: TextStyle(color: focusedBorderColor),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          labelText: hintText,
          labelStyle: TextStyle(color: hintcColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: focusedBorderColor, width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(width: borderWidth, color: Color(0xfff5f4f6)),
          ),
        ),
      ),
    );
  }
}

class EditTextIcon extends StatelessWidget {
  final Color focusedBorderColor;
  final Color hintColor;
  final String hintText;
  final double borderRadius;
  final double borderWidth;
  final Icon leadingIcon;
  final Color fillColor;
  final bool password;
  final TextEditingController textController;
  final int maxLines;
  final Function onTap;
  final bool readOnly;
  final TextInputType keyBoardType;
  final TextInputAction inputAction;

  EditTextIcon(
      {required this.focusedBorderColor,
        required this.hintColor,
      required this.borderRadius,
      required this.hintText,
      required this.leadingIcon,
      required this.fillColor,
      required this.borderWidth,
      required this.textController,
      required this.password,
      required this.maxLines,
      required this.onTap,
      required this.readOnly,
      required this.keyBoardType,
      required this.inputAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: password,
        controller: textController,
        maxLines: maxLines,
        onTap: () {
          onTap();
        },
        textAlign: TextAlign.start,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        textInputAction: inputAction,
        style: TextStyle(color: focusedBorderColor),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          prefixIcon: leadingIcon,
          fillColor: fillColor,
          hintText: hintText,
          labelText: hintText,
          labelStyle: TextStyle(color: hintColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: focusedBorderColor, width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(width: borderWidth, color: const Color(0xfff5f4f6)),
          ),
        ),
      ),
    );
  }
}
