class QRData {
  final String type;
  final String payload;
  final DateTime timestamp;

  const QRData({
    required this.type,
    required this.payload,
    required this.timestamp,
  });

  QRData copyWith({
    String? type,
    String? payload,
    DateTime? timestamp,
  }) {
    return QRData(
      type: type ?? this.type,
      payload: payload ?? this.payload,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
