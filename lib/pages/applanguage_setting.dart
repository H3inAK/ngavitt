import 'package:covid19app/constants/data.dart';
import 'package:covid19app/providers/language_provider.dart';
import 'package:covid19app/widgets/drawers/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LanguageSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0.2,
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                width: 20,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            );
          },
        ),
        title: FutureBuilder<Map<String, dynamic>>(
          future: Provider.of<LanguageProvider>(context, listen: false)
              .savedAppLanguage,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Consumer<LanguageProvider>(
                  builder: (context, snapshot, _) {
                return Text(
                  snapshot.appLanguage['changelanguage'].toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              });
            else
              return Text("");
          },
        ),
        actions: [
          FutureBuilder<Map<String, dynamic>>(
            future: Provider.of<LanguageProvider>(context, listen: false)
                .savedAppLanguage,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Consumer<LanguageProvider>(
                  builder: (context, snapshot, _) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton(
                        onChanged: (lang) async {
                          await Provider.of<LanguageProvider>(context,
                                  listen: false)
                              .changeLanguage(lang);
                        },
                        value: snapshot.appLanguage,
                        items: [
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/en.png'),
                                    fit: BoxFit.fill,
                                    width: 32,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("EN"),
                              ],
                            ),
                            value: AppLanguage.enLang,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/my.png'),
                                    fit: BoxFit.fill,
                                    width: 30,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("MY"),
                              ],
                            ),
                            value: AppLanguage.myLang,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/ch.jpg'),
                                    fit: BoxFit.fill,
                                    width: 30,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("CH"),
                              ],
                            ),
                            value: AppLanguage.chLang,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/ru.png'),
                                    fit: BoxFit.fill,
                                    width: 30,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("RU"),
                              ],
                            ),
                            value: AppLanguage.ruLang,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/vn.png'),
                                    fit: BoxFit.fill,
                                    width: 30,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("VN"),
                              ],
                            ),
                            value: AppLanguage.vnLang,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage('assets/images/th.jpeg'),
                                    fit: BoxFit.fill,
                                    width: 30,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("TH"),
                              ],
                            ),
                            value: AppLanguage.thLang,
                          ),
                        ],
                      ),
                    );
                  },
                );
              else
                return Text("");
            },
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Provider.of<LanguageProvider>(context, listen: false)
            .savedAppLanguage,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Consumer<LanguageProvider>(
              builder: (context, snapshot, _) {
                var appLang = snapshot.appLanguage;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(appLang['image']),
                            fit: BoxFit.fill,
                            width: 100,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        appLang['title'],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          else
            return Text("loading ...");
        },
      ),
    );
  }
}
