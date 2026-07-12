class Scout {
  final String id;
  final String email;
  final String role;
  final String createdAt;

  Scout({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  Scout copyWith({String? id, String? email, String? role, String? createdAt}) {
    return Scout(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(covariant Scout other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.role == role &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ role.hashCode ^ createdAt.hashCode;
  }
}
