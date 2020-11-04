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
      id: this.id ?? id,
      displayName: this.displayName ?? displayName,
      email: this.email ?? email,
      name: this.name ?? name,
      lastName: this.lastName ?? lastName,
      birth: this.birth ?? birth,
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
