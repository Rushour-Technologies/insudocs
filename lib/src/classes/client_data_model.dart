class ClientDataModel {
  ClientDataModel({
    required this.name,
    required this.insuranceType,
    required this.insuraceStatus,
    required this.email,
    required this.reportLink,
  });

  final String name;
  final int insuranceType;
  final int insuraceStatus;
  final String email;
  final String reportLink;

  factory ClientDataModel.fromMap(Map<String, dynamic> map) => ClientDataModel(
        name: map['name'] ?? 'Lorem',
        insuranceType: map['insuranceType'] ?? 0,
        insuraceStatus: map['insuraceStatus'] ?? 0,
        email: map['email'] ?? '',
        reportLink: map['reportLink'] ?? '',
      );
}
