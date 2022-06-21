import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/manga.dart';
import '../../../controllers/manga/manga_controller.dart';
import '../../common/responsive_layout.dart';
import 'desktop_validate_btn.dart';
import 'number_form_field.dart';
import 'synopsis_form_field.dart';
import 'title_form_field.dart';

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
  int? volumeCount;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(mangaControllerProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mangaControllerProvider);

    final isDesktop = ResponsiveLayout.isDesktop(context);
    final padding = isDesktop ? MediaQuery.of(context).size.width / 4 : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('editView.title')),
        actions: [
          if (!isDesktop)
            IconButton(
              onPressed: _validateForm,
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: padding),
          children: [
            TitleFormField(
              initialValue: widget.manga.title,
              onSaved: (val) => _title = val,
            ),
            SynopsysFormField(
              initialValue: widget.manga.synopsis,
            ),
            NumberFormField(
              initialValue: widget.manga.volumeCount,
              labelText: tr('editView.formLabel.volume'),
              onSaved: (val) => volumeCount = val,
            ),
            if (isDesktop) ...[
              const SizedBox(height: 16),
              DesktopValidateBtn(onPressed: _validateForm),
            ],
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
          volumeCount: volumeCount,
          volumeOwned: volumeCount != null
              ? widget.manga.volumeOwned
                  .where((e) => e <= volumeCount!)
                  .toList()
              : null,
        ),
      );
      if (mounted) context.pop();
    }
  }
}
