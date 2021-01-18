import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/counrty_status.dart';

class CountriesProvider with ChangeNotifier {
  List<CountryStatus> _countries = List();

  List<CountryStatus> get countries {
    return [..._countries];
  }

  Future<void> fetchAndSetCountriesData() async {
    final url = "https://corona.lmao.ninja/v3/covid-19/countries";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final countriesData = jsonDecode(response.body) as List<dynamic>;

      _countries.clear();
      countriesData.forEach((countryData) {
        _countries.add(CountryStatus.fromJson(countryData));
      });
      notifyListeners();
    } else {
      throw Exception("Failed to load data!");
    }
  }

  List<CountryStatus> findByContinent(String continent) {
    return _countries
        .where((country) => country.continent == continent)
        .toList();
  }

  void sortByNames({bool isAcse}) {
    _countries.sort((a, b) => a.countryName.compareTo(b.countryName));
    _countries = isAcse ? _countries : _countries.reversed.toList();

    notifyListeners();
  }

  void sortByActiveCases({bool isAcse}) {
    _countries.sort((a, b) => a.active.compareTo(b.active));
    _countries = isAcse ? _countries : _countries.reversed.toList();

    notifyListeners();
  }

  void sortByTotalCases({bool isAcse}) {
    _countries.sort((a, b) => a.cases.compareTo(b.cases));
    _countries = isAcse ? _countries : _countries.reversed.toList();

    notifyListeners();
  }
}
