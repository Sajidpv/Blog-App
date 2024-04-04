import 'package:blog_app/cores/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
  UserModel copyWith({
    String? email,
    name,
    id,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
