import 'package:flutter/foundation.dart';

class AppDrawerProvider with ChangeNotifier {
  int _currentMenuItem = 0;

  get currentMenuItem => _currentMenuItem;

  set setMenuItem(int item) => _currentMenuItem = item;
}
