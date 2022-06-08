import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DesktopValidateBtn extends StatelessWidget {
  final VoidCallback? onPressed;

  const DesktopValidateBtn({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32,
          ),
        ),
        onPressed: onPressed,
        label: Text(tr('editView.validationButton')),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
