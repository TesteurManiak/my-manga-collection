import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';

class EditButton extends StatelessWidget {
  final bool isFavorite;
  final String id;
  final bool isFloating;

  /// Index of the current page on the `HomeView`.
  ///
  /// This is needed for go_router navigation.
  final int index;

  const EditButton({
    Key? key,
    required this.isFavorite,
    required this.id,
    required this.index,
    this.isFloating = false,
  }) : super(key: key);

  const EditButton.floating({
    Key? key,
    required bool isFavorite,
    required String id,
    required int index,
  }) : this(
          key: key,
          isFavorite: isFavorite,
          id: id,
          index: index,
          isFloating: true,
        );

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.edit);
    if (isFloating) {
      return FloatingActionButton(
        onPressed: () => _goToEditPage(context),
        child: icon,
      );
    }
    return AnimatedOpacity(
      opacity: isFavorite ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        onPressed: () => _goToEditPage(context),
        icon: icon,
      ),
    );
  }

  void _goToEditPage(BuildContext context) {
    if (isFavorite) {
      context.pushNamed(
        AppRoute.edit.name,
        params: {'id': id, 'index': index.toString()},
      );
    }
  }
}
