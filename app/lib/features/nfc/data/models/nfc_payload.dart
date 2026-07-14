import 'dart:convert';
import '../../../profile/domain/entities/profile.dart';
import '../../domain/entities/nfc_data.dart';

class NFCPayload {
  NFCPayload._();

  static String encodeProfile(Profile profile) {
    final json = {
      'name': profile.name,
      'email': profile.email,
      'phone': profile.phone,
      'website': profile.website,
      'linkedin': profile.linkedin,
      'bio': profile.bio,
    };
    return jsonEncode(json);
  }

  static Profile decodeProfile(String payload) {
    final json = jsonDecode(payload) as Map<String, dynamic>;
    final now = DateTime.now();
    return Profile(
      id: now.millisecondsSinceEpoch.toString(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      linkedin: json['linkedin'] as String?,
      bio: json['bio'] as String?,
      createdAt: now,
      updatedAt: now,
    );
  }

  static NFCData encodeToNFC(Profile profile) {
    return NFCData(
      type: 'profile',
      payload: encodeProfile(profile),
      timestamp: DateTime.now(),
    );
  }
}
