import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validators.dart';
import '../../../../domain/entities/manga.dart';
import '../../../controllers/manga/manga_controller.dart';
import 'number_form_field.dart';

class MangaEditionForm extends ConsumerStatefulWidget {
  final Manga manga;

  const MangaEditionForm({Key? key, required this.manga}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaEditionFormState();
}

class _MangaEditionFormState extends ConsumerState<MangaEditionForm> {
  final _formKey = GlobalKey<FormState>();

  late final MangaController _controller;

  String? _title;
  int? _chapterCount;
  int? volumeCount;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(mangaControllerProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mangaControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('editView.title')),
        actions: [
          IconButton(
            onPressed: _validateForm,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: widget.manga.title,
              decoration: InputDecoration(
                labelText: tr('editView.formLabel.title'),
              ),
              validator: Validators.notEmpty,
              onSaved: (val) => _title = val,
            ),
            NumberFormField(
              initialValue: widget.manga.volumeCount,
              labelText: tr('editView.formLabel.volume'),
              onSaved: (val) => volumeCount = val,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateForm() async {
    final formState = _formKey.currentState!;
    if (formState.validate()) {
      formState.save();
      await _controller.updateManga(
        widget.manga.copyWith(
          title: _title,
          chapterCount: _chapterCount,
          volumeCount: volumeCount,
        ),
      );
      if (mounted) context.pop();
    }
  }
}
