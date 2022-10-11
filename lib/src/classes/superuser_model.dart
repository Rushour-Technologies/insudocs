import 'dart:convert';

class SuperUserModel {
  String name;
  String email;
  String phone;
  String qualification;
  int age;
  SuperUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.qualification,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'qualification': qualification,
      'age': age,
    };
  }

  factory SuperUserModel.fromMap(Map<String, dynamic> map) {
    return SuperUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      qualification: map['qualification'] ?? '',
      age: map['age']?.toInt() ?? 0,
    );
  }
}
