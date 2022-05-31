import 'package:easy_localization/easy_localization.dart';

abstract class Validators {
  static String? notEmpty(String? value) =>
      value?.isNotEmpty ?? false ? null : tr('validators.empty');
}
