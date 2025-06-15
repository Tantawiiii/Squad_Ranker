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
  final String? fromCompetition;
  final String? toCompetition;
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
     this.fromCompetition,
     this.toCompetition,
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
      fromCompetition: json['fromCompetitionID'] ?? '',
      toCompetition: json['toCompetitionID'] ?? '',
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
}
