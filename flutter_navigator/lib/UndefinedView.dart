import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String name;

  const UndefinedView({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$name Page Not Found',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
