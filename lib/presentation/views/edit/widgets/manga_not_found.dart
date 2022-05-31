import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/string_extensions.dart';

class MangaNotFound extends StatelessWidget {
  final String id;

  const MangaNotFound({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('editView.title'))),
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
