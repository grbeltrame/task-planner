class UserDtoNewUser {
  String name;
  String email;
  String password;

  UserDtoNewUser(this.name, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
