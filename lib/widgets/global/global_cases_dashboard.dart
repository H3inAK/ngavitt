import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
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
  Widget build(BuildContext context) {
    final appLang = Provider.of<LanguageProvider>(context).appLanguage;
    final globalStatusProvider =
        Provider.of<GlobalStatusProvider>(context, listen: false);
    _deviceSize = MediaQuery.of(context).size;

    // print(globalStatusProvider.isRefresh);
    print(_deviceSize.width);
    print(_deviceSize.height);

    return globalStatusProvider.isRefresh
        ? FutureBuilder<void>(
            future: _fetchGlobalStatus(context),
            builder: (ctx, dataSnapshot) {
              // print("inside futureBuilder()");
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.error == null) {
                globalStatusProvider.setRefresh = false;
                return buildGlobalStatusChartBoard(context, appLang);
              } else {
                return Center(
                  child: Text(dataSnapshot.error.toString()),
                );
              }
            },
          )
        : buildGlobalStatusChartBoard(context, appLang);
  }

  RefreshIndicator buildGlobalStatusChartBoard(
      BuildContext context, Map<String, dynamic> appLang) {
    return RefreshIndicator(
      onRefresh: () => _fetchGlobalStatus(context),
      child: Consumer<GlobalStatusProvider>(
        builder: (ctx, globalStatusData, _) {
          if (_deviceSize.width < 350)
            return buildGridView(
              appLang,
              globalStatusData,
              1,
            );
          else if (_deviceSize.width >= 350 && _deviceSize.width <= 700)
            return buildGridView(
              appLang,
              globalStatusData,
              2,
            );
          else if (_deviceSize.width > 700 && _deviceSize.width <= 1000)
            return buildGridView(
              appLang,
              globalStatusData,
              3,
            );
          else
            return buildGridView(
              appLang,
              globalStatusData,
              4,
            );
        },
      ),
    );
  }

  Container buildGridView(Map<String, dynamic> appLang,
      GlobalStatusProvider globalStatusData, int crossAxisCount) {
    return Container(
      height: double.infinity,
      child: GridView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: kIsWeb
              ? (3.45 / 2)
              : _deviceSize.height >= 600
                  ? (3.14 / 2)
                  : (2.9 / 2),
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        children: <InfoCard>[
          InfoCard(
            title: appLang['totalcases'],
            titleColor: Colors.orange[300],
            cases: globalStatusData.globalStatus.totalConfirmed,
            iconColor: Colors.orangeAccent[100],
          ),
          InfoCard(
            title: appLang['todaycases'],
            titleColor: Colors.orange[300],
            cases: globalStatusData.globalStatus.newConfirmed,
            iconColor: Colors.orangeAccent[100],
          ),
          InfoCard(
            title: appLang['totalrecovered'],
            titleColor: Colors.green[300],
            cases: globalStatusData.globalStatus.totalRecovered,
            iconColor: Colors.greenAccent[100],
          ),
          InfoCard(
            title: appLang['todayrecovered'],
            titleColor: Colors.green[300],
            cases: globalStatusData.globalStatus.newRecovered,
            iconColor: Colors.greenAccent[100],
          ),
          InfoCard(
            title: appLang['totaldeath'],
            titleColor: Colors.red[300],
            cases: globalStatusData.globalStatus.totalDeaths,
            iconColor: Colors.redAccent[100],
          ),
          InfoCard(
            title: appLang['todaydeath'],
            titleColor: Colors.red[300],
            cases: globalStatusData.globalStatus.newDeaths,
            iconColor: Colors.redAccent[100],
          ),
          if (_deviceSize.height >= 600)
            InfoCard(
              title: appLang['activecases'],
              titleColor: Colors.pink[300],
              cases: globalStatusData.globalStatus.activeCases,
              iconColor: Colors.pinkAccent[100],
            ),
          if (_deviceSize.height >= 600)
            InfoCard(
              title: appLang['criticalcases'],
              titleColor: Colors.pink[300],
              cases: globalStatusData.globalStatus.criticalCases,
              iconColor: Colors.pinkAccent[100],
            ),
        ],
      ),
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
