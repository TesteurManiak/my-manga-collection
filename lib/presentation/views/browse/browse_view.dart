import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/browse/browse_controller.dart';
import '../common/manga_list.dart';

class BrowseView extends ConsumerStatefulWidget {
  const BrowseView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends ConsumerState<BrowseView>
    with AutomaticKeepAliveClientMixin {
  final _textController = TextEditingController();

  late final BrowseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(browseControllerProvider.notifier);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pageState = ref.watch(browseControllerProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _textController,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: tr('browseView.searchHint'),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _textController.clear,
            ),
          ),
          onSubmitted: _controller.searchMangas,
        ),
        centerTitle: false,
      ),
      body: pageState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pageState.hasError
              ? Center(child: Text(tr('browseView.error')))
              : pageState.mangas.isEmpty
                  ? Center(child: Text(tr('browseView.emptyList')))
                  : MangaList(pageState.mangas),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
