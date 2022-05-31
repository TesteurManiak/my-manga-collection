import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object e, StackTrace? s)? error;

  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: error ??
          (e, __) {
            debugPrint(e.toString());
            return Center(child: Text(tr('errors.generic')));
          },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
