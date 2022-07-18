import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class SynopsisFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;

  const SynopsisFormField({super.key, this.initialValue, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: tr('editView.formLabel.synopsis'),
      ),
      keyboardType: TextInputType.multiline,
      validator: Validators.notEmpty,
      minLines: 1,
      maxLines: 20,
      onSaved: onSaved,
    );
  }
}
