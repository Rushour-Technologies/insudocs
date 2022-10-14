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

/// Filters enums
enum Filters {
  ALL,
  HEALTH,
  LIFE,
  CLAIM,
  TRACK,
}

extension InsuranceTypeExtension on InsuranceType {
  String get data => toString().split('.').last;
}

extension InsuranceStatusExtension on InsuranceStatus {
  String get data => toString().split('.').last;
}

extension FiltersExtension on Filters {
  String get data => toString().split('.').last;
}
