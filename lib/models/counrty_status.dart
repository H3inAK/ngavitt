class CountryStatus {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final String continent;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;
  final int critical;

  CountryStatus({
    this.countryName,
    this.countryFlag,
    this.countryCode,
    this.continent,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
  });

  factory CountryStatus.fromJson(Map<String, dynamic> json) {
    return CountryStatus(
      countryName: json['country'],
      countryFlag: json['countryInfo']['flag'],
      countryCode: json['countryInfo']['iso2'],
      continent: json['continent'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
    );
  }
}
