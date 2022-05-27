import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../controllers/browse/browse_controller.dart';

class BrowseView extends ConsumerStatefulWidget {
  const BrowseView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends ConsumerState<BrowseView>
    with AutomaticKeepAliveClientMixin {
  late final BrowseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(browseControllerProvider.notifier);
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
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Manga name...'.hardcoded,
          ),
          onSubmitted: _controller.searchMangas,
        ),
        centerTitle: false,
      ),
      body: pageState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pageState.mangas.isEmpty
              ? Center(child: Text('No mangas to display'.hardcoded))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: pageState.mangas.length,
                  itemBuilder: (_, index) {
                    final manga = pageState.mangas[index];
                    return ListTile(title: Text(manga.title));
                  },
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
