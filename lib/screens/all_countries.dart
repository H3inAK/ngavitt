import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/counrties_provider.dart';
import '../helpers/popup_submenu.dart';
import '../helpers/custom_routes.dart';
import '../widgets/continents/continent_widget.dart';
import '../widgets/countries/countries_list_widget.dart';
import 'search_screen.dart';

enum FilterOptions {
  SortbyNameAsec,
  SortbyNameDesc,
  SortbyActiveCasesAsec,
  SortbyActiveCasesDesc,
}

class AllCountriesScreen extends StatelessWidget {
  static const routeName = '/all-countries';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Builder(builder: (context) {
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, isInsideScrolling) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    centerTitle: true,
                    title: Text(
                      "All Countries",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).push(
                          FadedPageRoute(
                            child: SearchScreen(),
                            duration: const Duration(milliseconds: 100),
                          ),
                        ),
                        icon: Icon(Icons.search),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        tooltip: 'Parent menu',
                        onSelected: (value) {
                          print(value);
                        },
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupSubMenuItem<String>(
                              title: 'Sort by names',
                              items: [
                                "by ascending",
                                "by descending",
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == "by ascending") {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByNames(isAcse: true);
                                } else {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByNames(isAcse: false);
                                }
                              },
                            ),
                            PopupSubMenuItem<String>(
                              title: 'Sort by total cases',
                              items: [
                                "by ascending",
                                "by descending",
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == "by ascending") {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByTotalCases(isAcse: true);
                                } else {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByTotalCases(isAcse: false);
                                }
                              },
                            ),
                            PopupSubMenuItem<String>(
                              title: 'Sort by active cases',
                              items: [
                                "by ascending",
                                "by descending",
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == "by ascending") {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByActiveCases(isAcse: true);
                                } else {
                                  Provider.of<CountriesProvider>(context,
                                          listen: false)
                                      .sortByActiveCases(isAcse: false);
                                }
                              },
                            ),
                          ];
                        },
                      ),
                    ],
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.format_list_numbered_rtl),
                          text: "Countries",
                        ),
                        Tab(
                          icon: Icon(Icons.grid_view),
                          text: "Continents",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            body: TabBarView(children: [
              CountriesList(),
              Continents(),
            ]),
          );
        }),
      ),
    );
  }
}
