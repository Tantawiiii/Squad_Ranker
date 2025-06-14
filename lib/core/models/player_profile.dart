
class PlayerProfile {
  final String? playerID;
  final String? playerImage;
  final String? playerName;
  final String? playerFullName;
  final String? birthplace;
  final String? dateOfBirth;
  final String? dateOfDeath;
  final String? playerShirtNumber;
  final String? birthplaceCountry;
  final String? birthplaceCountryImage;
  final String? age;
  final String? height;
  final String? foot;
  final String? internationalTeam;
  final String? internationalTeamImage;
  final String? internationalTeamStatus;
  final String? internationalGames;
  final String? internationalGoals;
  final String? internationalTeamShortTag;
  final String? internationalShirtNumber;
  final bool? internationalWmMember;
  final int? internationalValueRank;
  final String? country;
  final String? countrynameEN;
  final String? countryImage;
  final String? countryShortName;
  final String? secondCountry;
  final String? secondCountryImage;
  final String? league;
  final String? leaguenameEN;
  final String? leagueLogo;
  final String? clubImage;
  final String? club;
  final String? clubnameEN;
  final String? clubID;
  final LoanInfo? loan;
  final String? contractExpiryDate;
  final String? agent;
  final String? agentId;
  final String? agentVerificationStatus;
//  final bool? agentVerificationDate;
  final String? outfitter;
  final String? positionGroup;
  final String? playerMainPosition;
  final String? playerSecondPosition;
  final String? playerThirdPosition;
  final String? marketValue;
  final String? marketValueCurrency;
  final String? marketValueNumeral;
  final String? marketValueLastChange;
  final List<dynamic>? relatedness;
  final InjuryInfo? injury;
  final AbsenceInfo? absence;
  final List<dynamic>? allSuspensions;

  PlayerProfile({
    this.playerID,
    this.playerImage,
    this.playerName,
    this.playerFullName,
    this.birthplace,
    this.dateOfBirth,
    this.dateOfDeath,
    this.playerShirtNumber,
    this.birthplaceCountry,
    this.birthplaceCountryImage,
    this.age,
    this.height,
    this.foot,
    this.internationalTeam,
    this.internationalTeamImage,
    this.internationalTeamStatus,
    this.internationalGames,
    this.internationalGoals,
    this.internationalTeamShortTag,
    this.internationalShirtNumber,
    this.internationalWmMember,
    this.internationalValueRank,
    this.country,
    this.countrynameEN,
    this.countryImage,
    this.countryShortName,
    this.secondCountry,
    this.secondCountryImage,
    this.league,
    this.leaguenameEN,
    this.leagueLogo,
    this.clubImage,
    this.club,
    this.clubnameEN,
    this.clubID,
    this.loan,
    this.contractExpiryDate,
    this.agent,
    this.agentId,
    this.agentVerificationStatus,
   // this.agentVerificationDate,
    this.outfitter,
    this.positionGroup,
    this.playerMainPosition,
    this.playerSecondPosition,
    this.playerThirdPosition,
    this.marketValue,
    this.marketValueCurrency,
    this.marketValueNumeral,
    this.marketValueLastChange,
    this.relatedness,
    this.injury,
    this.absence,
    this.allSuspensions,
  });

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    final player = json['playerProfile'];
    return PlayerProfile(
      playerID: player['playerID'],
      playerImage: player['playerImage'],
      playerName: player['playerName'],
      playerFullName: player['playerFullName'],
      birthplace: player['birthplace'],
      dateOfBirth: player['dateOfBirth'],
      dateOfDeath: player['dateOfDeath'],
      playerShirtNumber: player['playerShirtNumber'],
      birthplaceCountry: player['birthplaceCountry'],
      birthplaceCountryImage: player['birthplaceCountryImage'],
      age: player['age'],
      height: player['height'],
      foot: player['foot'],
      internationalTeam: player['internationalTeam'],
      internationalTeamImage: player['internationalTeamImage'],
      internationalTeamStatus: player['internationalTeamStatus'],
      internationalGames: player['internationalGames'],
      internationalGoals: player['internationalGoals'],
      internationalTeamShortTag: player['internationalTeamShortTag'],
      internationalShirtNumber: player['internationalShirtNumber'],
      internationalWmMember: player['internationalWmMember'],
      internationalValueRank: player['internationalValueRank'],
      country: player['country'],
      countrynameEN: player['countrynameEN'],
      countryImage: player['countryImage'],
      countryShortName: player['countryShortName'],
      secondCountry: player['secondCountry'],
      secondCountryImage: player['secondCountryImage'],
      league: player['league'],
      leaguenameEN: player['leaguenameEN'],
      leagueLogo: player['leagueLogo'],
      clubImage: player['clubImage'],
      club: player['club'],
      clubnameEN: player['clubnameEN'],
      clubID: player['clubID'],
      loan: player['loan'] != null ? LoanInfo.fromJson(player['loan']) : null,
      contractExpiryDate: player['contractExpiryDate'],
      agent: player['agent'],
      agentId: player['agentId'],
      agentVerificationStatus: player['agentVerificationStatus'],
     // agentVerificationDate: player['agentVerificationDate'],
      outfitter: player['outfitter'],
      positionGroup: player['positionGroup'],
      playerMainPosition: player['playerMainPosition'],
      playerSecondPosition: player['playerSecondPosition'],
      playerThirdPosition: player['playerThirdPosition'],
      marketValue: player['marketValue'],
      marketValueCurrency: player['marketValueCurrency'],
      marketValueNumeral: player['marketValueNumeral'],
      marketValueLastChange: player['marketValueLastChange'],
      relatedness: player['relatedness'],
      injury: player['injury'] != null ? InjuryInfo.fromJson(player['injury']) : null,
      absence: player['absence'] != null ? AbsenceInfo.fromJson(player['absence']) : null,
      allSuspensions: player['allSuspensions'],
    );
  }
}
class LoanInfo {
  final String? loan;
  final String? loanStart;
  final String? loanUntil;
  final String? contractOptions;
  final String? ownerName;
  final String? ownerID;
  final String? ownerImage;
  final String? ownerContractUntil;

  LoanInfo({
    this.loan,
    this.loanStart,
    this.loanUntil,
    this.contractOptions,
    this.ownerName,
    this.ownerID,
    this.ownerImage,
    this.ownerContractUntil,
  });

  factory LoanInfo.fromJson(Map<String, dynamic> json) {
    return LoanInfo(
      loan: json['loan'],
      loanStart: json['loanStart'],
      loanUntil: json['loanUntil'],
      contractOptions: json['contractOptions'],
      ownerName: json['ownerName'],
      ownerID: json['ownerID'],
      ownerImage: json['ownerImage'],
      ownerContractUntil: json['ownerContractUntil'],
    );
  }
}

class InjuryInfo {
  final String? id;
  final String? title;
  final String? until;
  final String? rehabilitationFlag;

  InjuryInfo({
    this.id,
    this.title,
    this.until,
    this.rehabilitationFlag,
  });

  factory InjuryInfo.fromJson(Map<String, dynamic> json) {
    return InjuryInfo(
      id: json['id'],
      title: json['title'],
      until: json['until'],
      rehabilitationFlag: json['rehabilitationFlag'],
    );
  }
}

class AbsenceInfo {
  final String? id;
  final String? title;
  final String? until;
  final String? competitionID;
  final String? matches;

  AbsenceInfo({
    this.id,
    this.title,
    this.until,
    this.competitionID,
    this.matches,
  });

  factory AbsenceInfo.fromJson(Map<String, dynamic> json) {
    return AbsenceInfo(
      id: json['id'],
      title: json['title'],
      until: json['until'],
      competitionID: json['competitionID'],
      matches: json['matches'],
    );
  }
}
