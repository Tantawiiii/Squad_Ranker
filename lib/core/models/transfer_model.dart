class Transfer {
  final String playerID;
  final String fromClubID;
  final String toClubID;
  final String? fee;
  final DateTime date;

  Transfer({
    required this.playerID,
    required this.fromClubID,
    required this.toClubID,
    required this.fee,
    required this.date,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      playerID: json['playerID'] ?? '',
      fromClubID: json['fromClubID'] ?? '',
      toClubID: json['toClubID'] ?? '',
      fee: json['transferFee']?['value'],
      date: DateTime.fromMillisecondsSinceEpoch(
        (json['transferredAt'] ?? 0) * 1000,
      ),
    );
  }
}
