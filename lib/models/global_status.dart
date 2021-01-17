class GlobalStatus {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final int activeCases;
  final int criticalCases;

  GlobalStatus({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.activeCases,
    this.criticalCases,
  });

  factory GlobalStatus.fromJson(Map<String, dynamic> json) {
    return GlobalStatus(
      newConfirmed: json['todayCases'],
      totalConfirmed: json['cases'],
      totalDeaths: json['deaths'],
      newDeaths: json['todayDeaths'],
      totalRecovered: json['recovered'],
      newRecovered: json['todayRecovered'],
      activeCases: json['active'],
      criticalCases: json['critical'],
    );
  }
}
