class Contact {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? linkedin;
  final String? website;
  final String? bio;
  final String source;
  final DateTime importedAt;

  const Contact({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.linkedin,
    this.website,
    this.bio,
    required this.source,
    required this.importedAt,
  });

  Contact copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? linkedin,
    String? website,
    String? bio,
    String? source,
    DateTime? importedAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      source: source ?? this.source,
      importedAt: importedAt ?? this.importedAt,
    );
  }
}
