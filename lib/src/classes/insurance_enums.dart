/// Insurance type enums
enum InsuranceType {
  HEALTH,
  LIFE,
}

/// Insurance status enums
enum InsuranceStatus {
  CLAIM,
  TRACK,
  APPROVED,
}

extension InsuranceTypeExtension on InsuranceType {
  String get data => toString().split('.').last;
}

extension InsuranceStatusExtension on InsuranceStatus {
  String get data => toString().split('.').last;
}
