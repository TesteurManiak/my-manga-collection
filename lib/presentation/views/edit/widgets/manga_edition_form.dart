import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../domain/entities/manga.dart';
import '../../../controllers/manga/manga_controller.dart';
import 'edition_title.dart';
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
    _controller = ref.read(mangaControllerProvider(widget.manga.id).notifier);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mangaControllerProvider(widget.manga.id));
    return Scaffold(
      appBar: AppBar(
        title: const EditionTitle(),
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
                labelText: 'Title'.hardcoded,
              ),
              validator: Validators.notEmpty,
              onSaved: (val) => _title = val,
            ),
            NumberFormField(
              initialValue: widget.manga.volumeCount,
              labelText: 'Volume count'.hardcoded,
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
