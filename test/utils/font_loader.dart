import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// This method is used to load the default Roboto font family from the
/// alchemist package.
Future<void> loadDefaultTestFont() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const robotoPath = 'assets/fonts/Roboto';
  await _loadFamily(
    package: 'alchemist',
    name: 'Roboto',
    assets: [
      '$robotoPath/Roboto-Black.ttf',
      '$robotoPath/Roboto-Bold.ttf',
      '$robotoPath/Roboto-Light.ttf',
      '$robotoPath/Roboto-Medium.ttf',
      '$robotoPath/Roboto-Regular.ttf',
      '$robotoPath/Roboto-Thin.ttf',
    ],
  );
}

Future<void> _loadFamily({
  required String package,
  required String name,
  required List<String> assets,
}) async {
  final prefix = 'packages/$package/';
  final fontLoader = FontLoader(name);

  for (final asset in assets) {
    final bytes = rootBundle.load('$prefix$asset');
    fontLoader.addFont(bytes);
  }
  await fontLoader.load();
}
