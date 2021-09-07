import 'package:covid19app/models/counrty_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/counrties_provider.dart';
import '../countries/country_item.dart';

class CountriesList extends StatefulWidget {
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  GlobalKey<SliverAnimatedListState> _sliverListKey =
      GlobalKey<SliverAnimatedListState>();
  List<CountryStatus> _countries = <CountryStatus>[];
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () => Provider.of<CountriesProvider>(context, listen: false)
            .fetchAndSetCountriesData(),
        child: Consumer<CountriesProvider>(
          builder: (ctx, countriesData, _) {
            print(countriesData.countries.length);
            // Future future = Future(() {});

            // countriesData.countries.forEach((country) {
            //   future = future.then((_) {
            //     return Future.delayed(
            //       const Duration(milliseconds: 20),
            //       () {
            //         try {
            //           _countries.clear();
            //           _countries.add(country);
            //           _sliverListKey.currentState
            //               .insertItem(_countries.length - 1);
            //         } catch (err) {
            //           throw Exception(err);
            //         }
            //       },
            //     );
            //   });
            // });

            // return CustomScrollView(
            //   physics: BouncingScrollPhysics(),
            //   slivers: [
            //     SliverPadding(
            //       padding: EdgeInsets.symmetric(
            //         vertical: 6,
            //         horizontal: 4,
            //       ),
            //       sliver: SliverAnimatedList(
            //         key: _sliverListKey,
            //         itemBuilder: (ctx, i, animation) {
            //           return SizeTransition(
            //             key: UniqueKey(),
            //             sizeFactor: animation,
            //             child: CountryItem(
            //               key: UniqueKey(),
            //               countryStatus: _countries[i],
            //               counter: i,
            //             ),
            //           );
            //         },
            //         initialItemCount: _countries.length,
            //       ),
            //     ),
            //   ],
            // );

            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(builder: (context) {
                return Scrollbar(
                  controller: _scrollController,
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 4,
                        ),
                        sliver: SliverAnimatedList(
                          key: _sliverListKey,
                          itemBuilder: (ctx, i, animation) {
                            return SizeTransition(
                              key: UniqueKey(),
                              sizeFactor: animation,
                              child: CountryItem(
                                key: UniqueKey(),
                                countryStatus: countriesData.countries[i],
                                counter: i,
                                isAninmate: true,
                              ),
                            );
                          },
                          initialItemCount: countriesData.countries.length,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
