import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';
import '../../features/profile/domain/entities/profile.dart';

class HiveAdapters {
  HiveAdapters._();

  static void register() {
    Hive.registerAdapter(_ProfileAdapter());
  }
}

class HiveService {
  static Box<Profile>? _profileBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    HiveAdapters.register();

    await Hive.openBox<Profile>(HiveBoxes.profiles);
  }

  static Box<Profile> get profileBox {
    _profileBox ??= Hive.box<Profile>(HiveBoxes.profiles);
    return _profileBox!;
  }

  static Future<void> close() async {
    await Hive.close();
    _profileBox = null;
  }

  static Future<void> deleteFromDisk() async {
    await Hive.deleteFromDisk();
    _profileBox = null;
  }
}

class _ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      linkedin: fields[4] as String?,
      website: fields[5] as String?,
      bio: fields[6] as String?,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.linkedin)
      ..writeByte(5)
      ..write(obj.website)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
