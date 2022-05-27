import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../controllers/browse/browse_controller.dart';
import 'widgets/manga_tile.dart';

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
            hintText: 'Manga name...'.hardcoded,
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
              ? Center(child: Text('An error occured'.hardcoded))
              : pageState.mangas.isEmpty
                  ? Center(child: Text('No mangas to display'.hardcoded))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: pageState.mangas.length,
                      itemBuilder: (_, index) {
                        final manga = pageState.mangas[index];
                        return MangaTile(manga: manga);
                      },
                      separatorBuilder: (_, __) => const Divider(),
                    ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
