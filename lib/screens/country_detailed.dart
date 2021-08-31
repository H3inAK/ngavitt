import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/data.dart';
import '../providers/country_status_provider.dart';
import '../pages/pie_chart_country.dart';
import '../widgets/cards/info_card.dart';

class CountryDetailsScreen extends StatefulWidget {
  static const routeName = '/country-details';

  @override
  _CountryDetailsScreenState createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  Future<void> _fetchCountryData(BuildContext ctx, String countryName) async {
    await Provider.of<CountryStatusProvider>(ctx, listen: false)
        .fetchAndSetCountryStatus(countryName.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final countryName = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          countryName + "'s Covid-19 Status",
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        elevation: 0.2,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: _fetchCountryData(context, countryName),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(radius: 20),
            );
          } else if (dataSnapshot.error == null) {
            return Consumer<CountryStatusProvider>(
              builder: (ctx, countryData, _) {
                return PageView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          height: 160,
                          child: Card(
                            elevation: 20,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                    width: 120,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          countryData.countryStatus.countryFlag,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 6.0,
                                          color: Colors.black87,
                                          offset: Offset(0.0, 6.4),
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        countryData.countryStatus.countryName +
                                            " (" +
                                            countryData
                                                .countryStatus.countryCode +
                                            ") ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () =>
                                _fetchCountryData(context, countryName),
                            child: GridView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 22,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: deviceSize.height >= 700
                                    ? (2.6 / 2)
                                    : (2.9 / 2),
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                              ),
                              children: [
                                InfoCard(
                                  title: "Total Cases",
                                  titleColor: Colors.orange[400],
                                  cases: countryData.countryStatus.cases,
                                  iconColor: Colors.orange[100],
                                ),
                                InfoCard(
                                  title: "Today Cases",
                                  titleColor: Colors.orange[400],
                                  cases: countryData.countryStatus.todayCases,
                                  iconColor: Colors.orange[100],
                                ),
                                InfoCard(
                                  title: "Total Recovered",
                                  titleColor: Colors.green[400],
                                  cases: countryData.countryStatus.recovered,
                                  iconColor: Colors.green[100],
                                ),
                                InfoCard(
                                  title: "New Recovered",
                                  titleColor: Colors.green[400],
                                  cases:
                                      countryData.countryStatus.todayRecovered,
                                  iconColor: Colors.green[100],
                                ),
                                InfoCard(
                                  title: "Total Deaths",
                                  titleColor: Colors.red[400],
                                  cases: countryData.countryStatus.deaths,
                                  iconColor: Colors.red[100],
                                ),
                                InfoCard(
                                  title: "New Deaths",
                                  titleColor: Colors.red[400],
                                  cases: countryData.countryStatus.todayDeaths,
                                  iconColor: Colors.red[100],
                                ),
                                InfoCard(
                                  title: "Active Cases",
                                  titleColor: Colors.red[400],
                                  cases: countryData.countryStatus.active,
                                  iconColor: Colors.red[100],
                                ),
                                InfoCard(
                                  title: "Critical",
                                  titleColor: Colors.red[400],
                                  cases: countryData.countryStatus.critical,
                                  iconColor: Colors.red[100],
                                ),
                              ],
                            ),
                          ),
                        ),
                        deviceSize.height >= 600
                            ? Container(
                                height: 60,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: kPrimaryColor,
                                      offset: Offset(0.0, 0.4),
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.rotate_right,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "Refresh Cases",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    buildPieChartCountryPage(countryData),
                  ],
                );
              },
            );
          } else {
            return Text(dataSnapshot.error.toString());
          }
        },
      ),
    );
  }

  PieChartCountryPage buildPieChartCountryPage(
      CountryStatusProvider countryData) {
    return PieChartCountryPage(
      [
        ChartData(
          name: "Active",
          color: Colors.orange[400],
          percent: (countryData.countryStatus.active /
                  countryData.countryStatus.cases) *
              100,
        ),
        ChartData(
          name: "Recovered",
          color: Colors.green[400],
          percent: (countryData.countryStatus.recovered /
                  countryData.countryStatus.cases) *
              100,
        ),
        ChartData(
          name: "Deaths",
          color: Colors.redAccent[400],
          percent: (countryData.countryStatus.deaths /
                  countryData.countryStatus.cases) *
              100,
        ),
      ],
    );
  }
}
