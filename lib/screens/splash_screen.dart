import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../helpers/custom_routes.dart';
import '../providers/counrties_provider.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (_) {
        Provider.of<CountriesProvider>(context, listen: false)
            .fetchAndSetCountriesData()
            .then(
              (_) => Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => HomeScreen(),
                ),
              ),
            )
            .catchError(
          (err) {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Connection Error"),
                  content: Text("you have no internet connection"),
                  actions: [
                    FlatButton(
                      onPressed: () {},
                      child: Text("okay"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 120,
              height: 120,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/virus.svg",
                width: double.infinity,
                height: double.infinity,
                color: kPrimaryColor,
              ),
            ),
            Text(
              "NGAVITT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
