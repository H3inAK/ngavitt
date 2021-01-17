import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './constants/constants.dart';
import './providers/global_status_provider.dart';
import './providers/counrties_provider.dart';
import './providers/country_status_provider.dart';
import './screens/splash_screen.dart';
import './screens/search_screen.dart';
import './screens/all_countries.dart';
import './screens/country_detailed.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: kPrimaryColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0.6,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: kPrimaryColor,
            ),
          ),
        ),
        home: SplashScreen(),
        routes: {
          SearchScreen.routeName: (ctx) => SearchScreen(),
          AllCountriesScreen.routeName: (ctx) => AllCountriesScreen(),
          CountryDetailsScreen.routeName: (ctx) => CountryDetailsScreen(),
        },
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
              return CupertinoPageRoute(
                builder: (ctx) => SearchScreen(),
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
