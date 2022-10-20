/// Approval Status Enum for a request
enum ApprovalStatus {
  REJECTED,
  PENDING,
  APPROVED,
}

extension ApprovalStatusExtension on ApprovalStatus {
  String get data => toString().split('.').last;
}
