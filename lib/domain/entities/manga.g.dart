// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaAdapter extends TypeAdapter<Manga> {
  @override
  final int typeId = 1;

  @override
  Manga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Manga(
      id: fields[0] as String,
      link: fields[1] as String,
      synopsis: fields[2] as String,
      title: fields[3] as String,
      posterImage: fields[4] as MangaImages,
      coverImage: fields[5] as MangaImages?,
      chapterCount: fields[6] as int?,
      volumeCount: fields[7] as int?,
      volumeOwned: (fields[8] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Manga obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.synopsis)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.posterImage)
      ..writeByte(5)
      ..write(obj.coverImage)
      ..writeByte(6)
      ..write(obj.chapterCount)
      ..writeByte(7)
      ..write(obj.volumeCount)
      ..writeByte(8)
      ..write(obj.volumeOwned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
