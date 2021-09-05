import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/data.dart';
import '../models/counrty_status.dart';
import '../pages/pie_chart_country.dart';
import '../providers/country_status_provider.dart';
import '../screens/search_screen.dart';
import '../widgets/cards/info_card.dart';

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
  var _currentPage = 0;

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
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await Provider.of<CountryStatusProvider>(context, listen: false)
                  .fetchAndSetCountryStatus(widget.countryStatus.countryName);
            },
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                buildSliverAppBar(context),
                if (deviceSize.width < 350)
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    sliver: SliverList(
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
                if (deviceSize.width > 350 && deviceSize.width <= 600)
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
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
          elevation: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
              vertical: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  icon: Icon(
                    Icons.bar_chart_rounded,
                    size: _currentPage == 0 ? 32 : 28,
                    color: _currentPage == 0
                        ? Theme.of(context).accentColor
                        : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  icon: Icon(
                    Icons.data_usage,
                    size: _currentPage == 1 ? 32 : 28,
                    color: _currentPage == 1
                        ? Theme.of(context).accentColor
                        : Colors.grey,
                  ),
                ),
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
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () =>
              Navigator.of(context).popAndPushNamed(SearchScreen.routeName),
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FontAwesome.search,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
      stretch: true,
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "  ${widget.countryStatus.countryName}(${widget.countryStatus.countryCode})  ",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(),
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
