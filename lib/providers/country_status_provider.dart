import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/counrty_status.dart';

class CountryStatusProvider with ChangeNotifier {
  CountryStatus _countryStatus = CountryStatus();

  CountryStatus get countryStatus {
    return _countryStatus;
  }

  Future<void> fetchAndSetCountryStatus(String countryName) async {
    final url = "https://corona.lmao.ninja/v3/covid-19/countries/$countryName";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      _countryStatus = CountryStatus.fromJson(responseData);
      notifyListeners();
    } else {
      throw Exception("failed to load data!");
    }
  }
}
