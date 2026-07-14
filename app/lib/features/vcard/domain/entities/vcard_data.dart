class VCardData {
  final String version;
  final String? firstName;
  final String? lastName;
  final String? organization;
  final String? title;
  final String? email;
  final String? phone;
  final String? website;
  final String? address;
  final String? note;
  final String? photo;
  final String? linkedin;

  const VCardData({
    this.version = '3.0',
    this.firstName,
    this.lastName,
    this.organization,
    this.title,
    this.email,
    this.phone,
    this.website,
    this.address,
    this.note,
    this.photo,
    this.linkedin,
  });

  String get fullName {
    final parts = <String>[];
    if (firstName != null && firstName!.isNotEmpty) parts.add(firstName!);
    if (lastName != null && lastName!.isNotEmpty) parts.add(lastName!);
    return parts.join(' ');
  }

  VCardData copyWith({
    String? version,
    String? firstName,
    String? lastName,
    String? organization,
    String? title,
    String? email,
    String? phone,
    String? website,
    String? address,
    String? note,
    String? photo,
    String? linkedin,
  }) {
    return VCardData(
      version: version ?? this.version,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      organization: organization ?? this.organization,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      address: address ?? this.address,
      note: note ?? this.note,
      photo: photo ?? this.photo,
      linkedin: linkedin ?? this.linkedin,
    );
  }
}
