import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String photo;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      photo: json['photo'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  @override
  List<Object?> get props => [uid, name, email, photo];
}
