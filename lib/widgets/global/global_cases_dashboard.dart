import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/global_status_provider.dart';
import '../cards/info_card.dart';

class GlobalCasesDashboard extends StatefulWidget {
  @override
  _GlobalCasesDashboardState createState() => _GlobalCasesDashboardState();
}

class _GlobalCasesDashboardState extends State<GlobalCasesDashboard> {
  Size _deviceSize;

  Future<void> _fetchGlobalStatus(BuildContext ctx) async {
    await Provider.of<GlobalStatusProvider>(ctx, listen: false)
        .fetchAndSetGlobalStatus();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _deviceSize = MediaQuery.of(context).size;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchGlobalStatus(context),
      builder: (ctx, dataSnapshot) {
        print("inside futureBuilder()");
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataSnapshot.error == null) {
          return RefreshIndicator(
            onRefresh: () => _fetchGlobalStatus(context),
            child: Consumer<GlobalStatusProvider>(
              builder: (ctx, globalStatusData, _) {
                print("refreshGlobalStatus()");
                return Container(
                  height: double.infinity,
                  child: GridView(
                    padding: EdgeInsets.only(bottom: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          _deviceSize.height >= 600 ? (3.14 / 2) : (2.9 / 2),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    children: <InfoCard>[
                      InfoCard(
                        title: "Total Confirmed",
                        titleColor: Colors.orange[300],
                        cases: globalStatusData.globalStatus.totalConfirmed,
                        iconColor: Colors.orange[100],
                      ),
                      InfoCard(
                        title: "New Confirmed",
                        titleColor: Colors.orange[300],
                        cases: globalStatusData.globalStatus.newConfirmed,
                        iconColor: Colors.orange[100],
                      ),
                      InfoCard(
                        title: "Total Recovered",
                        titleColor: Colors.green[300],
                        cases: globalStatusData.globalStatus.totalRecovered,
                        iconColor: Colors.green[100],
                      ),
                      InfoCard(
                        title: "New Recovered",
                        titleColor: Colors.green[300],
                        cases: globalStatusData.globalStatus.newRecovered,
                        iconColor: Colors.green[100],
                      ),
                      InfoCard(
                        title: "Total Deaths",
                        titleColor: Colors.red[300],
                        cases: globalStatusData.globalStatus.totalDeaths,
                        iconColor: Colors.red[100],
                      ),
                      InfoCard(
                        title: "New Deaths",
                        titleColor: Colors.red[300],
                        cases: globalStatusData.globalStatus.newDeaths,
                        iconColor: Colors.red[100],
                      ),
                      if (_deviceSize.height >= 600)
                        InfoCard(
                          title: "Active Cases",
                          titleColor: Colors.red[300],
                          cases: globalStatusData.globalStatus.activeCases,
                          iconColor: Colors.red[100],
                        ),
                      if (_deviceSize.height >= 600)
                        InfoCard(
                          title: "Critical Cases",
                          titleColor: Colors.red[300],
                          cases: globalStatusData.globalStatus.criticalCases,
                          iconColor: Colors.red[100],
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text(dataSnapshot.error),
          );
        }
      },
    );
  }

  Card buildCard(String title, int cases, Color bgColor, Color textColor) {
    return Card(
      color: bgColor.withOpacity(0.9),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              cases.toString(),
              style: TextStyle(
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
