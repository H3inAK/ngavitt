import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/counrties_provider.dart';
import '../helpers/custom_routes.dart';
import '../helpers/popup_submenu.dart';
import '../screens/search_screen.dart';
import '../widgets/countries/country_item.dart';

class ContinentCountriesList extends StatelessWidget {
  final String continentName;

  ContinentCountriesList(this.continentName);

  @override
  Widget build(BuildContext context) {
    final countries =
        Provider.of<CountriesProvider>(context).findByContinent(continentName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          continentName + " Countries",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
        elevation: 0.2,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              PopupScalePageRoute(
                child: SearchScreen(),
              ),
            ),
            icon: Icon(
              FontAwesome.search,
              size: 22,
            ),
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
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByNames(isAcse: true);
                    } else {
                      Provider.of<CountriesProvider>(context, listen: false)
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
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByTotalCases(isAcse: true);
                    } else {
                      Provider.of<CountriesProvider>(context, listen: false)
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
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByActiveCases(isAcse: true);
                    } else {
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByActiveCases(isAcse: false);
                    }
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 4,
          ),
          itemCount: countries.length,
          itemBuilder: (ctx, i) {
            return CountryItem(
              countryStatus: countries[i],
              counter: i,
              isAninmate: true,
            );
          },
        ),
      ),
    );
  }
}
