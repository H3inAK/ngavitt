import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/global_status.dart';

class GlobalStatusProvider with ChangeNotifier {
  GlobalStatus _globalStatus = GlobalStatus();

  GlobalStatus get globalStatus {
    return _globalStatus;
  }

  Future<void> fetchAndSetGlobalStatus() async {
    final url = "https://corona.lmao.ninja/v3/covid-19/all";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      _globalStatus = GlobalStatus.fromJson(responseData);
      notifyListeners();
    } else {
      throw Exception("failed to load data!");
    }
  }

  // may be used later
  void changeSignal() {
    notifyListeners();
  }
}
