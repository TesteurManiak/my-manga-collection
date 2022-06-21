import 'package:flutter/material.dart';

class CustomSpinner extends StatelessWidget {
  final double? size;

  const CustomSpinner({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return const UnconstrainedBox(
      child: CircularProgressIndicator(),
    );
  }
}
