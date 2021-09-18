import 'dart:math';

import 'package:covid19app/providers/global_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_routes.dart';
import '../providers/counrties_provider.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _onWillPop = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (_) {
        Provider.of<GlobalStatusProvider>(context, listen: false)
            .fetchAndSetGlobalStatus()
            .then(
          (value) {
            Provider.of<CountriesProvider>(context, listen: false)
                .fetchAndSetCountriesData()
                .then(
                  (_) => Navigator.of(context).pushReplacement(
                    SimplePageRoute(
                      builder: (ctx) => HomeScreen(),
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                )
                .catchError(
              (err) {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(Icons.signal_wifi_bad),
                          SizedBox(width: 20),
                          Text("Connection Error"),
                        ],
                      ),
                      content: Text("you have no internet connection!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            setState(() {
                              _onWillPop = true;
                            });
                          },
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
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print(_onWillPop);
        return _onWillPop;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
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
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.bounceInOut,
                  child: SvgPicture.asset(
                    "assets/icons/virus.svg",
                    width: double.infinity,
                    height: double.infinity,
                    color: Theme.of(context).accentColor,
                  ),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: (2 * pi) * value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );
                  },
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                child: Text(
                  "NGAVITT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, 400 * value),
                    child: child,
                  );
                },
              ),
              SizedBox(height: 20),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                child: Container(
                  width: 100,
                  height: 20,
                  child: LinearProgressIndicator(
                    color: Theme.of(context).accentColor,
                    // size: MediaQuery.of(context).size.height * 0.12,
                  ),
                ),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, -400 * value),
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
