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
      synopsis: fields[1] as String,
      title: fields[2] as String,
      posterImage: fields[3] as MangaImages,
      coverImage: fields[4] as MangaImages?,
      volumeCount: fields[5] as int?,
      volumeOwned: (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Manga obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.synopsis)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.posterImage)
      ..writeByte(4)
      ..write(obj.coverImage)
      ..writeByte(5)
      ..write(obj.volumeCount)
      ..writeByte(6)
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
