// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaImagesAdapter extends TypeAdapter<MangaImages> {
  @override
  final int typeId = 2;

  @override
  MangaImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaImages(
      tinyUrl: fields[0] as String?,
      smallUrl: fields[1] as String?,
      mediumUrl: fields[2] as String?,
      largeUrl: fields[3] as String?,
      originalUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MangaImages obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tinyUrl)
      ..writeByte(1)
      ..write(obj.smallUrl)
      ..writeByte(2)
      ..write(obj.mediumUrl)
      ..writeByte(3)
      ..write(obj.largeUrl)
      ..writeByte(4)
      ..write(obj.originalUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
