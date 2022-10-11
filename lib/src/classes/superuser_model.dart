import 'dart:convert';

class SuperUserModel {
  String name;
  String qualification;
  int age;
  SuperUserModel({
    required this.name,
    required this.qualification,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qualification': qualification,
      'age': age,
    };
  }

  factory SuperUserModel.fromMap(Map<String, dynamic> map) {
    return SuperUserModel(
      name: map['name'] ?? '',
      qualification: map['qualification'] ?? '',
      age: map['age']?.toInt() ?? 0,
    );
  }
}
