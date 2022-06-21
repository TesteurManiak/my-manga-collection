import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class TitleFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;

  const TitleFormField({super.key, this.initialValue, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: tr('editView.formLabel.title'),
      ),
      validator: Validators.notEmpty,
      onSaved: onSaved,
    );
  }
}
