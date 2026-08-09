import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/contacts/domain/entities/contact.dart';
import '../../features/settings/domain/entities/settings.dart';

class HiveAdapters {
  HiveAdapters._();

  static void register() {
    Hive.registerAdapter(_ProfileAdapter());
    Hive.registerAdapter(_ContactAdapter());
    Hive.registerAdapter(_SettingsAdapter());
  }
}

class HiveService {
  static Box<Profile>? _profileBox;
  static Box<Contact>? _contactBox;
  static Box? _settingsBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    HiveAdapters.register();

    await Hive.openBox<Profile>(HiveBoxes.profiles);
    await Hive.openBox<Contact>(HiveBoxes.contacts);
    _settingsBox = await Hive.openBox(HiveBoxes.settings);
  }

  static Box<Profile> get profileBox {
    _profileBox ??= Hive.box<Profile>(HiveBoxes.profiles);
    return _profileBox!;
  }

  static Box<Contact> get contactBox {
    _contactBox ??= Hive.box<Contact>(HiveBoxes.contacts);
    return _contactBox!;
  }

  static Box get settingsBox {
    _settingsBox ??= Hive.box(HiveBoxes.settings);
    return _settingsBox!;
  }

  static Future<void> close() async {
    await Hive.close();
    _profileBox = null;
    _contactBox = null;
    _settingsBox = null;
  }

  static Future<void> deleteFromDisk() async {
    await Hive.deleteFromDisk();
    _profileBox = null;
    _contactBox = null;
    _settingsBox = null;
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
      photoPath: fields[7] as String?,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      instagram: fields[10] as String?,
      facebook: fields[11] as String?,
      x: fields[12] as String?,
      social: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.photoPath)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.instagram)
      ..writeByte(11)
      ..write(obj.facebook)
      ..writeByte(12)
      ..write(obj.x)
      ..writeByte(13)
      ..write(obj.social);
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

class _ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      linkedin: fields[4] as String?,
      website: fields[5] as String?,
      bio: fields[6] as String?,
      source: fields[7] as String,
      importedAt: fields[8] as DateTime,
      instagram: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.source)
      ..writeByte(8)
      ..write(obj.importedAt)
      ..writeByte(9)
      ..write(obj.instagram);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class _SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 2;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      themeMode: ThemeMode.values[fields[0] as int],
      locale: Locale(fields[1] as String, fields[2] as String),
      biometricEnabled: fields[3] as bool,
      pinEnabled: fields[4] as bool,
      adsEnabled: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.themeMode.index)
      ..writeByte(1)
      ..write(obj.locale.languageCode)
      ..writeByte(2)
      ..write(obj.locale.countryCode)
      ..writeByte(3)
      ..write(obj.biometricEnabled)
      ..writeByte(4)
      ..write(obj.pinEnabled)
      ..writeByte(5)
      ..write(obj.adsEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
