class ClientModel {
  ClientModel({
    required this.name,
    required this.insuranceType,
    required this.insuraceStatus,
    required this.email,
    required this.reportLink,
    required this.uid,
    required this.photoURL,
  });

  final String photoURL;
  final String name;
  final String uid;
  final int insuranceType;
  final int insuraceStatus;
  final String email;
  final String reportLink;

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      photoURL: map['photoURL'] ?? '',
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      insuranceType: map['insuranceType']?.toInt() ?? 0,
      insuraceStatus: map['insuraceStatus']?.toInt() ?? 0,
      email: map['email'] ?? '',
      reportLink: map['reportLink'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoURL': photoURL,
      'name': name,
      'uid': uid,
      'insuranceType': insuranceType,
      'insuraceStatus': insuraceStatus,
      'email': email,
      'reportLink': reportLink,
    };
  }
}
