import 'package:covid19app/providers/language_provider.dart';
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

//fix the continent language bug
var continent = {
  'အာရှ': "Asia",
  'အာဖရိက': "Africa",
  'ဥရောပ': "Europe",
  'တောင်အမေရိက': "South America",
  'မြောက်အမေရိက': "North America",
  'ဩစတေးလျ': "Australia-Oceania",
  'เอเชีย': "Asia",
  'แอฟริกา': "Africa",
  'ยุโรป': "Europe",
  'อเมริกาเหนือ': "South America",
  'อเมริกาใต้': "North America",
  'ออสเตรเลีย': "Australia-Oceania",
  'Châu Á': "Asia",
  'Châu phi': "Africa",
  'Châu Âu': "Europe",
  'Nam Mỹ': "South America",
  'Bắc Mỹ': "North America",
  'Châu Úc': "Australia-Oceania",
  'Азия': "Asia",
  'Африке': "Africa",
  'Европа': "Europe",
  'Южная Америка': "South America",
  'Северная Америка': "North America",
  'Австралия': "Australia-Oceania",
  '亚洲': "Asia",
  '非洲': "Africa",
  '欧洲': "Europe",
  '北美': "South America",
  '南美洲': "North America",
  '澳大利亚': "Australia-Oceania",
};

class ContinentCountriesList extends StatelessWidget {
  final String continentName;

  ContinentCountriesList(this.continentName);

  @override
  Widget build(BuildContext context) {
    final appLang = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).appLanguage;
    final countries = Provider.of<CountriesProvider>(context).findByContinent(
      appLang['code'] == 'en' ? continentName : continent[continentName],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          continentName + " " + appLang['countries'],
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
                  title: appLang['sortbyName'],
                  items: [
                    appLang['byascending'],
                    appLang['bydescending'],
                  ],
                  onSelected: (String filterOptions) {
                    if (filterOptions == appLang['byascending']) {
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByNames(isAcse: true);
                    } else {
                      Provider.of<CountriesProvider>(context, listen: false)
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
                      Provider.of<CountriesProvider>(context, listen: false)
                          .sortByTotalCases(isAcse: true);
                    } else {
                      Provider.of<CountriesProvider>(context, listen: false)
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
