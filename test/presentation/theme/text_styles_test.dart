import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:my_manga_collection/presentation/style/text_styles.dart';

import '../../utils/font_loader.dart';

void main() {
  goldenTest(
    'text styles rendering',
    fileName: 'text_styles',
    pumpBeforeTest: (tester) async {
      await loadDefaultTestFont();
    },
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
