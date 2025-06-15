class PlayerTransferDetail {
  final String? playerID;
  final String? oldClubID;
  final String oldClubName;
  final String? oldClubImage;
  final String? newClubID;
  final String newClubName;
  final String? newClubImage;
  final String transferFeeValue;
  final String? transferFeeCurrency;
  final String? transferFeeNumeral;
  final String? fromCompetitionID;
  final String? toCompetitionID;
  final String? playerName;
  final String? playerImage;
  final String? countryID;
  final String countryImage;
  final String? loan;
  final String? date;
  final String? season;
  final String? newClubCountryName;
  final String? newClubCountryImage;

  PlayerTransferDetail({
    this.playerID,
    this.oldClubID,
    required this.oldClubName,
    this.oldClubImage,
    this.newClubID,
    required this.newClubName,
    this.newClubImage,
    required this.transferFeeValue,
    this.transferFeeCurrency,
    this.transferFeeNumeral,
     this.fromCompetitionID,
     this.toCompetitionID,
    this.playerName,
    this.playerImage,
    this.countryID,
    required this.countryImage,
    this.loan,
    this.date,
    this.season,
    this.newClubCountryName,
    this.newClubCountryImage,
  });

  factory PlayerTransferDetail.fromJson(Map<String, dynamic> json) {
    return PlayerTransferDetail(
      playerID: json['playerID'],
      oldClubID: json['oldClubID'],
      oldClubName: json['oldClubName'] ?? '',
      oldClubImage: json['oldClubImage'],
      newClubID: json['newClubID'],
      newClubName: json['newClubName'] ?? '',
      newClubImage: json['newClubImage'],
      transferFeeValue: json['transferFeeValue'] ?? '',
      transferFeeCurrency: json['transferFeeCurrency'],
      transferFeeNumeral: json['transferFeeNumeral'],
      fromCompetitionID: json['fromCompetitionID'] ?? '',
      toCompetitionID: json['toCompetitionID'] ?? '',
      playerName: json['playerName'],
      playerImage: json['playerImage'],
      countryID: json['countryID'],
      countryImage: json['countryImage'] ?? '',
      loan: json['loan'],
      date: json['date'],
      season: json['season'],
      newClubCountryName: json['newClubCountryName'],
      newClubCountryImage: json['newClubCountryImage'],
    );
  }

  String? get formattedDate {
    try {
      final parts = date!.split('.');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2].substring(2);
        return '$day.$month.$year';
      }
    } catch (_) {}
    return date;
  }

}
