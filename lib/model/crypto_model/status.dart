/// Represents the status information for a cryptocurrency API request.
class Status {
  /// The timestamp of the API request.
  DateTime? timestamp;

  /// Error code, if any, for the API request.
  int? errorCode;

  /// Error message, if any, for the API request.
  dynamic errorMessage;

  /// Time elapsed for the API request.
  int? elapsed;

  /// Credit count for the API request.
  int? creditCount;

  /// Notice, if any, for the API request.
  dynamic notice;

  /// Total count, if applicable, for the API request.
  int? totalCount;

  /// Constructor for the `Status` class.
  Status({
    this.timestamp,
    this.errorCode,
    this.errorMessage,
    this.elapsed,
    this.creditCount,
    this.notice,
    this.totalCount,
  });

  /// Creates a `Status` object from a JSON map.
  factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp'] as String),
        errorCode: json['error_code'] as int?,
        errorMessage: json['error_message'] as dynamic,
        elapsed: json['elapsed'] as int?,
        creditCount: json['credit_count'] as int?,
        notice: json['notice'] as dynamic,
        totalCount: json['total_count'] as int?,
      );

  /// Converts the `Status` object to a JSON map.
  Map<String, dynamic> toJson() => {
        'timestamp': timestamp?.toIso8601String(),
        'error_code': errorCode,
        'error_message': errorMessage,
        'elapsed': elapsed,
        'credit_count': creditCount,
        'notice': notice,
        'total_count': totalCount,
      };
}
