class UserModel{
  
  final String? name;
  final String? email;
  final String? password;
  final String token;
  final String role;

UserModel({
  required this.name,
  required this.email,
  required this.password,
  required this.token,
  required this.role,
}); 

bool get canCreateProducts => role == 'admin'|| role == 'vendor';
}

