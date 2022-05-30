import '../extensions/string_extensions.dart';

abstract class Validators {
  static String? notEmpty(String? value) =>
      value?.isNotEmpty ?? false ? null : 'This field is required'.hardcoded;
}
