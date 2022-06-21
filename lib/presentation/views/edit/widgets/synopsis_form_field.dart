import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class SynopsysFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;

  const SynopsysFormField({super.key, this.initialValue, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.multiline,
        expands: true,
        validator: Validators.notEmpty,
        onSaved: onSaved,
        maxLines: null,
        minLines: null,
      ),
    );
  }
}
