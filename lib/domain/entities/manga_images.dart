import 'dart:convert';

import 'package:equatable/equatable.dart';

class MangaImages extends Equatable {
  final String? tinyUrl;
  final String? smallUrl;
  final String? mediumUrl;
  final String? largeUrl;
  final String? originalUrl;

  const MangaImages({
    required this.tinyUrl,
    required this.smallUrl,
    required this.mediumUrl,
    required this.largeUrl,
    required this.originalUrl,
  });

  /// Return the smallest image url.
  String get smallestImageUrl {
    if (tinyUrl != null) {
      return tinyUrl!;
    } else if (smallUrl != null) {
      return smallUrl!;
    } else if (mediumUrl != null) {
      return mediumUrl!;
    } else if (largeUrl != null) {
      return largeUrl!;
    } else {
      return originalUrl!;
    }
  }

  String get biggestImageUrl {
    if (originalUrl != null) {
      return originalUrl!;
    } else if (largeUrl != null) {
      return largeUrl!;
    } else if (mediumUrl != null) {
      return mediumUrl!;
    } else if (smallUrl != null) {
      return smallUrl!;
    } else {
      return tinyUrl!;
    }
  }

  @override
  List<Object?> get props => [
        tinyUrl,
        smallUrl,
        mediumUrl,
        largeUrl,
        originalUrl,
      ];

  Map<String, dynamic> toJson() {
    return {
      'tiny': tinyUrl,
      'small': smallUrl,
      'medium': mediumUrl,
      'large': largeUrl,
      'original': originalUrl,
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}
