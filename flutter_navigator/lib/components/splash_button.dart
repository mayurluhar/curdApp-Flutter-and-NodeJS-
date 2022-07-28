import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_navigator/utils/constant.dart';


class MaterialSplashButton extends StatelessWidget {
  final Color color;
  final Function onTap;
  final double height, width;
  final String text;
  final double borderRadius;

  MaterialSplashButton(
      {
        Key? key,
        required this.color,
      required this.onTap,
      required this.height,
      required this.width,
      required this.text,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: Text(
            text,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}

class IconSplashButton extends StatelessWidget {
  final double height;
  final Function onTap;
  final Icon icon;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  IconSplashButton(

      { Key? key,
        required this.height, required this.onTap, required this.icon, required this.borderWidth,required this.borderRadius, required this.borderColor}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: IconButton(
          icon: icon,
          onPressed: () {
            onTap();
          }),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final bool showButton;
  final Function onPress;
  final String heroTag;

  const FormButton(
      {required this.showButton, required this.onPress, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showButton,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: kAppBarColor,
          )
        ]),
        child: FloatingActionButton(
          heroTag: heroTag,
          child: Icon(
            FontAwesomeIcons.plus,
            size: 20.0,
          ),
          backgroundColor: kAppBarColor,
          onPressed: () {
            onPress();
          },
        ),
      ),
    );
  }
}
