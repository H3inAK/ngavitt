import 'package:covid19app/constants/data.dart';
import 'package:covid19app/models/counrty_status.dart';
import 'package:covid19app/pages/pie_chart_country.dart';
import 'package:covid19app/widgets/cards/info_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountryCovidStatusDetails extends StatefulWidget {
  final CountryStatus countryStatus;

  const CountryCovidStatusDetails({Key key, this.countryStatus})
      : super(key: key);

  @override
  _CountryCovidStatusDetailsState createState() =>
      _CountryCovidStatusDetailsState();
}

class _CountryCovidStatusDetailsState extends State<CountryCovidStatusDetails> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    List<Map<String, Object>> allstatus = [
      {
        "cases": widget.countryStatus.cases,
        "color": Colors.orangeAccent,
        "title": "Total Comfirmed",
      },
      {
        "cases": widget.countryStatus.todayCases,
        "color": Colors.orangeAccent,
        "title": "New Comfirmed",
      },
      {
        "cases": widget.countryStatus.recovered,
        "color": Colors.greenAccent,
        "title": "Total Recovered",
      },
      {
        "cases": widget.countryStatus.todayRecovered,
        "color": Colors.greenAccent,
        "title": "Today Recovered",
      },
      {
        "cases": widget.countryStatus.deaths,
        "color": Colors.redAccent,
        "title": "Total Deaths",
      },
      {
        "cases": widget.countryStatus.todayDeaths,
        "color": Colors.redAccent,
        "title": "Today Deaths",
      },
      {
        "cases": widget.countryStatus.active,
        "color": Colors.orangeAccent,
        "title": "Active Cases",
      },
      {
        "cases": widget.countryStatus.critical,
        "color": Colors.orangeAccent,
        "title": "Critical Cases",
      },
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              buildSliverAppBar(context),
              if (deviceSize.width < 350)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      return InfoCard(
                        cases: allstatus[index]["cases"],
                        title: allstatus[index]["title"],
                        iconColor: allstatus[index]["color"],
                        titleColor: allstatus[index]["color"],
                      );
                    },
                    childCount: allstatus.length,
                  ),
                ),
              if (deviceSize.width > 350 && deviceSize.width <= 600)
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          deviceSize.height >= 600 ? (3.14 / 2) : (2.9 / 2),
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        return InfoCard(
                          cases: allstatus[index]["cases"],
                          title: allstatus[index]["title"],
                          iconColor: allstatus[index]["color"],
                          titleColor: allstatus[index]["color"],
                        );
                      },
                      childCount: allstatus.length,
                    ),
                  ),
                ),
              if (deviceSize.width > 600 && deviceSize.width <= 1200)
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:
                          deviceSize.height >= 600 ? (3.14 / 2) : (2.9 / 2),
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        return InfoCard(
                          cases: allstatus[index]["cases"],
                          title: allstatus[index]["title"],
                          iconColor: allstatus[index]["color"],
                          titleColor: allstatus[index]["color"],
                        );
                      },
                      childCount: allstatus.length,
                    ),
                  ),
                ),
            ],
          ),
          buildPieChartCountryPage(widget.countryStatus),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: Icon(
                    Icons.bar_chart_rounded,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  icon: Icon(
                    Icons.data_usage,
                    color: Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      stretch: true,
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        title: Text(
          "  ${widget.countryStatus.countryName}(${widget.countryStatus.countryCode})  ",
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
        ),
        background: SizedBox.expand(
          child: Hero(
            tag: widget.countryStatus.countryName ??
                ValueKey(widget.countryStatus.countryFlag),
            child: Image.network(
              widget.countryStatus.countryFlag,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

PieChartCountryPage buildPieChartCountryPage(CountryStatus countryStatus) {
  return PieChartCountryPage(
    [
      ChartData(
        name: "Active",
        color: Colors.orange[400],
        percent: (countryStatus.active / countryStatus.cases) * 100,
      ),
      ChartData(
        name: "Recovered",
        color: Colors.green[400],
        percent: (countryStatus.recovered / countryStatus.cases) * 100,
      ),
      ChartData(
        name: "Deaths",
        color: Colors.redAccent[400],
        percent: (countryStatus.deaths / countryStatus.cases) * 100,
      ),
    ],
  );
}
