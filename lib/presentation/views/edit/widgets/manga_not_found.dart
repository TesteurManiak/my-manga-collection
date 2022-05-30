import 'package:flutter/material.dart';

import '../../../../core/extensions/string_extensions.dart';
import 'edition_title.dart';

class MangaNotFound extends StatelessWidget {
  final String id;

  const MangaNotFound({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const EditionTitle()),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'No manga corresponding to id $id was found'.hardcoded,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
