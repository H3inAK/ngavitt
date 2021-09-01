import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/data.dart';
import '../models/global_status.dart';
import '../providers/global_status_provider.dart';
import '../widgets/drawers/app_drawer.dart';

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  int touchedIndex;
  GlobalStatus globalStatus = GlobalStatus();
  List<ChartData> data = [];

  @override
  void initState() {
    globalStatus =
        Provider.of<GlobalStatusProvider>(context, listen: false).globalStatus;

    data = [
      ChartData(
          name: 'Active',
          percent:
              (globalStatus.activeCases / globalStatus.totalConfirmed) * 100,
          color: Colors.orange[400]),
      ChartData(
          name: 'Recovered',
          percent:
              (globalStatus.totalRecovered / globalStatus.totalConfirmed) * 100,
          color: Colors.green[400]),
      ChartData(
          name: 'Deaths',
          percent:
              (globalStatus.totalDeaths / globalStatus.totalConfirmed) * 100,
          color: Colors.red[400]),
    ];

    super.initState();
  }

  List<PieChartSectionData> getSections(int touchedIndex) {
    return data
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final double fontSize = isTouched ? 25 : 16;
          final double radius = isTouched ? 100 : 80;

          final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: data.percent.toStringAsFixed(2).toString() + "%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  Widget buildIndicator({
    @required Color color,
    @required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.caption.color,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  color: Theme.of(context).accentColor,
                  width: 20,
                ),
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
              );
            },
          ),
          title: Text(
            "GLOBAL CHART STATUS",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          centerTitle: true,
          elevation: 0.2,
        ),
        body: Container(
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 360,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput
                                    is LongPressSemanticsEvent ||
                                pieTouchResponse.touchInput
                                    is LongPressEndDetails) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse
                                  .touchedSection.touchedSectionIndex;
                            }
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0.2,
                      centerSpaceRadius: 32,
                      sections: getSections(touchedIndex),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data
                            .map(
                              (data) => Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: buildIndicator(
                                  color: data.color,
                                  text: data.name,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
