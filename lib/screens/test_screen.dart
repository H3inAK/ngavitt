import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../themes/theme_service.dart';
import './search_screen.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitcher(
                    builder: (context) {
                      return IconButton(
                        onPressed: () async {
                          var themeName =
                              ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);

                          ThemeSwitcher.of(context).changeTheme(
                            theme: theme,
                            reverseAnimation:
                                themeName == 'light' ? true : false,
                          );
                        },
                        icon: ThemeProvider.of(context).brightness ==
                                Brightness.dark
                            ? Icon(Icons.wb_sunny, size: 25)
                            : Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("something"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => SearchScreen(),
                    ),
                  );
                }),
            PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text("take action one"),
                  ),
                  PopupMenuItem(
                    child: Text("take action two"),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Text("something"),
      ),
    );
  }
}
