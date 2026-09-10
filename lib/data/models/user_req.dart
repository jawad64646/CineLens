class UserReq {
  final String email;
  final String password;

  UserReq({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
