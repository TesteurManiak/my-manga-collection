import 'package:go_router/go_router.dart';

extension LocationUri on GoRouter {
  /// Parse the current location as a [Uri] object.
  Uri get locationUri => Uri.parse(location);
}
