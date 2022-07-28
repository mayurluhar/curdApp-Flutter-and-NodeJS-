import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final Function onChanged;
  const RadioButton(
      {Key? key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            onChanged(value);
          },
        ),
        const Text(
          "Male",
          style: TextStyle(fontSize: 14, color: Colors.red),
        ),
      ],
    );
  }
}
