class User {
  const User({
    this.id,
    this.displayName,
    this.email,
    this.name,
    this.lastName,
    this.birth,
  });

  final String id;
  final String displayName;
  final String email;
  final String name;
  final String lastName;
  final String birth;

  User copyWith({
    String id,
    String displayName,
    String email,
    String name,
    String lastName,
    String birth,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birth: birth ?? this.birth,
    );
  }

  static User empty = User(
    id: "",
    email: "",
    displayName: "",
    name: "",
    lastName: "",
    birth: "",
  );
}
