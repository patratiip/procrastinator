class MyUserEntity {
  String userId;
  String email;
  String? name;
  String? photoURL;

  MyUserEntity({
    required this.userId,
    required this.email,
    this.name,
    this.photoURL,
  });

  Map<String, Object?> toDocument() {
    return {
      'uid': userId,
      'email': email,
      if (name != null) 'name': name,
      if (photoURL != null) 'photoURL': photoURL,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['uid'],
      email: doc['email'],
      name: doc['name'],
      photoURL: doc['photoURL'],
    );
  }
}
