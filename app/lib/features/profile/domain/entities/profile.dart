class Profile {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? linkedin;
  final String? website;
  final String? bio;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Profile({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.linkedin,
    this.website,
    this.bio,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? linkedin,
    String? website,
    String? bio,
    String? photoPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
