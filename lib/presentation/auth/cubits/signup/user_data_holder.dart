class UserDataHolder {
  UserDataHolder({
    this.emailAddress,
    this.userName,
    this.bio,
    this.password,
    this.id,
  });

  final String? emailAddress;
  final String? userName;
  final String? bio;
  final String? password;
  final String? id;

  UserDataHolder copyWith({
    String? emailAddress,
    String? userName,
    String? bio,
    String? password,
    String? id,
  }) {
    return UserDataHolder(
      emailAddress: emailAddress ?? this.emailAddress,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() => {
        'emailAddress': emailAddress,
        'userName': userName,
        'bio': bio,
        'password': password,
        'id': id,
      };
}
