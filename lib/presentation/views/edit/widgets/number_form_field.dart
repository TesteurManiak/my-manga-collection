import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormField extends StatelessWidget {
  final int? initialValue;
  final String? labelText;
  final FormFieldSetter<int>? onSaved;

  const NumberFormField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue?.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onSaved: (val) {
        if (val != null) {
          onSaved?.call(int.tryParse(val));
        } else {
          onSaved?.call(null);
        }
      },
    );
  }
}
