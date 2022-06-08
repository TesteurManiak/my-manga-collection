import 'package:flutter/material.dart';

class CustomSpinner extends StatelessWidget {
  final double? size;

  const CustomSpinner({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UnconstrainedBox(
      child: CircularProgressIndicator(),
    );
  }
}
