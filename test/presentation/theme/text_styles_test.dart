import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_manga_collection/presentation/style/text_styles.dart';

import '../../utils/font_loader.dart';

void main() {
  const isRunningInCi = bool.fromEnvironment('CI', defaultValue: false);

  setUpAll(() async {
    await loadDefaultTestFont();
  });

  goldenTest(
    'text styles rendering',
    fileName: 'text_styles',
    skip: isRunningInCi,
    builder: () => GoldenTestGroup(
      children: const AppTextStyles()
          .props
          .map<GoldenTestScenario>(
            (e) => GoldenTestScenario(
              name: e.name,
              child: Text('Hello world!', style: e.property),
            ),
          )
          .toList(),
    ),
  );
}
