/// Insurance type enums
enum InsuranceType {
  HEALTH,
  LIFE,
}

/// Insurance status enums
enum InsuranceStatus {
  FILE,
  TRACK,
  CLEARED,
}

/// Filters enums
enum Filters {
  ALL,
  HEALTH,
  LIFE,
  FILE,
  TRACK,
  CLEARED,
}

enum ApprovalStatus {
  REJECTED,
  PENDING,
  APPROVED,
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

extension ApprovalStatusExtension on ApprovalStatus {
  String get data => toString().split('.').last;
}
