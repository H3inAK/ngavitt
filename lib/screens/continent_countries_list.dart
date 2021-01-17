import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counrties_provider.dart';
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
        title: Text(continentName + " Countries"),
        elevation: 0.2,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 4,
          ),
          itemCount: countries.length,
          itemBuilder: (ctx, i) {
            return CountryItem(countries[i], i);
          },
        ),
      ),
    );
  }
}
