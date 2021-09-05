import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:covid19app/helpers/custom_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/global_status_provider.dart';
import './providers/counrties_provider.dart';
import './providers/country_status_provider.dart';
import '../themes/theme_service.dart';
import './screens/splash_screen.dart';
import './screens/search_screen.dart';
import './screens/all_countries.dart';
import './screens/country_detailed.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black38,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final themeServise = await ThemeService.instance;
  final initTheme = themeServise.initial;
  runApp(MyApp(theme: initTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  MyApp({this.theme});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      child: Builder(
        builder: (BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => GlobalStatusProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => CountriesProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => CountryStatusProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Covid-19 Tracker',
            theme: ThemeProvider.of(context),
            home: SplashScreen(),
            routes: {
              SearchScreen.routeName: (ctx) => SearchScreen(),
              AllCountriesScreen.routeName: (ctx) => AllCountriesScreen(),
              CountryDetailsScreen.routeName: (ctx) => CountryDetailsScreen(),
            },
            // ignore: missing_return
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case CountryDetailsScreen.routeName:
                  return CupertinoPageRoute(
                    builder: (ctx) => CountryDetailsScreen(),
                    settings: settings,
                  );
                case AllCountriesScreen.routeName:
                  return CupertinoPageRoute(
                    builder: (ctx) => AllCountriesScreen(),
                    settings: settings,
                  );
                case SearchScreen.routeName:
                  return FadedPageRoute(
                    child: SearchScreen(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
