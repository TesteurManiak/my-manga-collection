import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';

class EditButton extends StatelessWidget {
  final bool isFavorite;
  final String id;

  const EditButton({
    Key? key,
    required this.isFavorite,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isFavorite ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        onPressed: isFavorite
            ? () => context.pushNamed(
                  AppRoute.edit.name,
                  params: {'id': id},
                )
            : null,
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
