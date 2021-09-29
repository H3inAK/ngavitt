import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/counrties_provider.dart';
import '../providers/language_provider.dart';
import '../helpers/popup_submenu.dart';
import '../helpers/custom_routes.dart';
import '../widgets/continents/continent_widget.dart';
import '../widgets/additionals/popup_submenu.dart' as psm;
import '../widgets/countries/countries_list_widget.dart';
import 'search_screen.dart';

class AllCountriesScreen extends StatelessWidget {
  static const routeName = '/all-countries';

  @override
  Widget build(BuildContext context) {
    final appLang = Provider.of<LanguageProvider>(context).appLanguage;

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
                      appLang['allcountries'],
                      style: GoogleFonts.lato(
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
                        icon: Icon(
                          FontAwesome.search,
                          size: 22,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        tooltip: 'Sort Countries',
                        onSelected: (value) {
                          print(value);
                        },
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupSubMenuItem<String>(
                              title: appLang['sortbyName'],
                              items: [
                                appLang['byascending'],
                                appLang['bydescending'],
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == appLang['byascending']) {
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
                              title: appLang['sortbytotalcases'],
                              items: [
                                appLang['byascending'],
                                appLang['bydescending'],
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == appLang['byascending']) {
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
                              title: appLang['sortbyactivecases'],
                              items: [
                                appLang['byascending'],
                                appLang['bydescending'],
                              ],
                              onSelected: (String filterOptions) {
                                if (filterOptions == appLang['byascending']) {
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
                        //   itemBuilder: (context) {
                        //     return [
                        //       psm.PopupSubMenu(
                        //         title: appLang['sortbyactivecases'],
                        //         items: [
                        //           psm.PopupSubMenuItem(),
                        //         ],
                        //         onSelected: (psm.FilterOptions filterOptions) {
                        //           if (filterOptions ==
                        //               psm.FilterOptions.SortbyActiveCasesAsec) {
                        //             Provider.of<CountriesProvider>(context,
                        //                     listen: false)
                        //                 .sortByActiveCases(isAcse: true);
                        //           } else {
                        //             Provider.of<CountriesProvider>(context,
                        //                     listen: false)
                        //                 .sortByActiveCases(isAcse: false);
                        //           }
                        //         },
                        //       ),
                        //     ];
                        //   },
                      ),
                    ],
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.format_list_numbered_rtl),
                          text: appLang['countries'],
                        ),
                        Tab(
                          icon: Icon(Icons.grid_view),
                          text: appLang['continents'],
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
