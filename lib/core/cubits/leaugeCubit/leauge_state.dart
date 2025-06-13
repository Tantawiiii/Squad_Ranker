import '../../../screens/leagues/widgets/leauges_widget.dart';
import '../../models/league_model.dart';

class LeaugeState {
  static List<Map<String, dynamic>> leaguesStatic = [
    {
      'index': 0,
      'name': 'Premier League',
      'id': 'GB1',
      'country': 'England',
      'score': 0,
      'isOpened': true,
      'isNew': false
    },
    {
      'index': 1,
      'name': 'La Liga',
      'id': 'ES1',
      'country': 'Spain',
      'score': 0,
      'isOpened': true,
      'isNew': false
    },
    {
      'index': 2,
      'name': 'Serie A',
      'id': 'IT1',
      'country': 'Italy',
      'score': 0,
      'isOpened': true,
      'isNew': false
    },
    {
      'index': 3,
      'name': 'Bundesliga',
      'id': 'L1',
      'country': 'Germany',
      'score': 100,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 4,
      'name': 'Ligue 1',
      'id': 'FR1',
      'country': 'France',
      'score': 300,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 5,
      'name': 'Liga Portugal',
      'id': 'PO1',
      'country': 'Portugal',
      'score': 500,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 6,
      'name': 'Süper Lig',
      'id': 'TR1',
      'country': 'Turkey',
      'score': 800,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 7,
      'name': 'Eredivisie',
      'id': 'NL1',
      'country': 'Netherlands',
      'score': 1000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 8,
      'name': 'Jupiler Pro League',
      'id': 'BE1',
      'country': 'Belgium',
      'score': 2000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 9,
      'name': 'Super League 1',
      'id': 'GR1',
      'country': 'Greece',
      'score': 3000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 10,
      'name': 'Scottish Premiership',
      'id': 'SC1',
      'country': 'Scotland',
      'score': 4000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 11,
      'name': 'Premier Liga',
      'id': 'UKR1',
      'country': 'Ukraine',
      'score': 5000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 12,
      'name': 'Superliga',
      'id': 'DK1',
      'country': 'Denmark',
      'score': 6000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 13,
      'name': 'Super League',
      'id': 'C1',
      'country': 'Switzerland',
      'score': 7000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 14,
      'name': 'Bundesliga (Austria)',
      'id': 'A1',
      'country': 'Austria',
      'score': 8000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 15,
      'name': 'Ligat ha\'Al',
      'id': 'ISR1',
      'country': 'Israel',
      'score': 9000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 16,
      'name': 'PKO BP Ekstraklasa',
      'id': 'PL1',
      'country': 'Poland',
      'score': 10000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 17,
      'name': 'Allsvenskan',
      'id': 'SE1',
      'country': 'Sweden',
      'score': 11000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 18,
      'name': 'Campeonato Brasileiro Série A',
      'id': 'BRA1',
      'country': 'Brazil',
      'score': 12000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 19,
      'name': 'Liga MX Clausura',
      'id': 'MEX1',
      'country': 'Mexico',
      'score': 13000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 20,
      'name': 'Liga MX Apertura',
      'id': 'MEXA',
      'country': 'Mexico',
      'score': 14000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 21,
      'name': 'Championship',
      'id': 'GB2',
      'country': 'England',
      'score': 15000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 22,
      'name': 'Major League Soccer',
      'id': 'MLS1',
      'country': 'USA',
      'score': 16000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 23,
      'name': 'MLS Next Pro',
      'id': 'MNP3',
      'country': 'USA',
      'score': 17000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 24,
      'name': 'J1 League',
      'id': 'JAP1',
      'country': 'Japan',
      'score': 18000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 25,
      'name': 'Ligue 2',
      'id': 'FR2',
      'country': 'France',
      'score': 19000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 26,
      'name': 'Torneo Federal A',
      'id': 'ARG3',
      'country': 'Argentina',
      'score': 20000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 27,
      'name': 'Serie B',
      'id': 'IT2',
      'country': 'Italy',
      'score': 21000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 28,
      'name': 'Bundesliga 2',
      'id': 'L2',
      'country': 'Germany',
      'score': 22000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 29,
      'name': 'A-League Men',
      'id': 'AUS1',
      'country': 'Australia',
      'score': 23000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 30,
      'name': 'Chinese Super League',
      'id': 'CSL',
      'country': 'China',
      'score': 24000,
      'isOpened': false,
      'isNew': false
    },
    {
      'index': 31,
      'name': 'USL Championship',
      'id': 'USL',
      'country': 'USA',
      'score': 25000,
      'isOpened': false,
      'isNew': false
    },
  ];

  String? openedTitle;
  CheckBox? checkBoxType;
  String? closedTitle;
  bool isActive;
  List<LeagueModel> leauges;
  int balance;
  List<Map<String, dynamic>> sellectedLeauges;
  LeaugeState({
    this.openedTitle,
    this.checkBoxType,
    this.closedTitle,
    this.isActive = false,
    this.leauges = const [],
    this.balance = 300,
    this.sellectedLeauges = const [
      {
        'index': 0,
        'name': 'Premier League',
        'id': 'GB1',
        'country': 'England',
        'score': 0,
        'isOpened': true,
        'isNew': false
      },
      {
        'index': 1,
        'name': 'La Liga',
        'id': 'ES1',
        'country': 'Spain',
        'score': 0,
        'isOpened': true,
        'isNew': false
      },
    ],
  });

  LeaugeState copyWith({
    String? getopenedTitle,
    CheckBox? getcheckBoxType,
    String? getclosedTitle,
    bool? getisActive,
    List<LeagueModel>? getleauges,
    List<Map<String, dynamic>>? getsellectedLeauges,
  }) {
    return LeaugeState(
      openedTitle: getopenedTitle ?? openedTitle,
      checkBoxType: getcheckBoxType ?? checkBoxType,
      closedTitle: getclosedTitle ?? closedTitle,
      isActive: getisActive ?? isActive,
      leauges: getleauges ?? leauges,
      sellectedLeauges: getsellectedLeauges ?? sellectedLeauges,
    );
  }
}
