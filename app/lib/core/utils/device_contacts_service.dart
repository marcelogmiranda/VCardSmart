import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceContactSuggestion {
  final String name;
  final String? email;
  final String? phone;
  final String? organization;

  const DeviceContactSuggestion({
    required this.name,
    this.email,
    this.phone,
    this.organization,
  });
}

class DeviceContactsService {
  static Future<bool> requestPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  static Future<List<DeviceContactSuggestion>> searchContacts(String query) async {
    if (query.isEmpty) return [];

    final hasPermission = await Permission.contacts.isGranted;
    if (!hasPermission) {
      final granted = await requestPermission();
      if (!granted) return [];
    }

    try {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: false,
      );

      final results = <DeviceContactSuggestion>[];
      final queryLower = query.toLowerCase();

      for (final contact in contacts) {
        if (contact.displayName.toLowerCase().contains(queryLower)) {
          String? email;
          String? phone;
          String? org;

          if (contact.emails.isNotEmpty) {
            email = contact.emails.first.address;
          }
          if (contact.phones.isNotEmpty) {
            phone = contact.phones.first.number;
          }
          if (contact.organizations.isNotEmpty) {
            org = contact.organizations.first.company;
          }

          results.add(
            DeviceContactSuggestion(
              name: contact.displayName,
              email: email,
              phone: phone,
              organization: org,
            ),
          );
          if (results.length >= 10) break;
        }
      }

      return results;
    } catch (_) {
      return [];
    }
  }

  static Future<List<DeviceContactSuggestion>> getAllContacts() async {
    final hasPermission = await Permission.contacts.isGranted;
    if (!hasPermission) {
      final granted = await requestPermission();
      if (!granted) return [];
    }

    try {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: false,
      );

      return contacts.take(50).map((contact) {
        String? email;
        String? phone;
        String? org;

        if (contact.emails.isNotEmpty) {
          email = contact.emails.first.address;
        }
        if (contact.phones.isNotEmpty) {
          phone = contact.phones.first.number;
        }
        if (contact.organizations.isNotEmpty) {
          org = contact.organizations.first.company;
        }

        return DeviceContactSuggestion(
          name: contact.displayName,
          email: email,
          phone: phone,
          organization: org,
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
