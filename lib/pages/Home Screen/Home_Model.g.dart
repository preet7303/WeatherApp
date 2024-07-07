// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Home_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchSaveAdapter extends TypeAdapter<SearchSave> {
  @override
  final int typeId = 0;

  @override
  SearchSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchSave(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchSave obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
