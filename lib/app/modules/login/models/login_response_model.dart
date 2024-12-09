class LoginResponseModel {
  final String token;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String address;

  LoginResponseModel({
    required this.token,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final user = json['data']['user'];
    return LoginResponseModel(
      token: json['data']['token'],
      userId: user['_id'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      email: user['email'],
      address: user['address'],
    );
  }
}
