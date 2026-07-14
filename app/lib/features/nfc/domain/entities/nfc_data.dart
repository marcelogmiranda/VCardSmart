class NFCData {
  final String type;
  final String payload;
  final DateTime timestamp;

  const NFCData({
    required this.type,
    required this.payload,
    required this.timestamp,
  });

  NFCData copyWith({
    String? type,
    String? payload,
    DateTime? timestamp,
  }) {
    return NFCData(
      type: type ?? this.type,
      payload: payload ?? this.payload,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
