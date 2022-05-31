import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MangaNotFound extends StatelessWidget {
  const MangaNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('editView.title'))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            tr('mangaView.notFound'),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
