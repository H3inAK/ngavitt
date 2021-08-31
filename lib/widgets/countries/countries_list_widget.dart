import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/counrties_provider.dart';
import '../countries/country_item.dart';

class CountriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () => Provider.of<CountriesProvider>(context, listen: false)
            .fetchAndSetCountriesData(),
        child: Consumer<CountriesProvider>(
          builder: (ctx, countriesData, _) {
            print(countriesData.countries.length);
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 4,
              ),
              itemCount: countriesData.countries.length,
              itemBuilder: (ctx, i) {
                return CountryItem(countriesData.countries[i], i);
              },
            );
          },
        ),
      ),
    );
  }
}
