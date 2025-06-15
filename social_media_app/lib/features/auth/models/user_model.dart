class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({required this.name, required this.email, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) => UserModel(
    name: jsonData['name'],
    email: jsonData['email'],
    password: jsonData['password'],
  );
}
