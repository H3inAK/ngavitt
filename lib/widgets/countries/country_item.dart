import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../models/counrty_status.dart';
import '../../providers/counrties_provider.dart';
import '../../providers/language_provider.dart';
import '../../helpers/custom_routes.dart';
import '../../screens/country_covid_status_details.dart';

class CountryItem extends StatelessWidget {
  final Key key;
  final CountryStatus countryStatus;
  final int counter;
  final bool isAninmate;

  CountryItem({
    this.key,
    this.countryStatus,
    this.counter,
    this.isAninmate = false,
  });

  @override
  Widget build(BuildContext context) {
    SortingType sortingType = Provider.of<CountriesProvider>(context).sortType;
    final appLang =
        Provider.of<LanguageProvider>(context, listen: false).appLanguage;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.bounceOut,
      builder: (context, value, child) {
        // return isAninmate
        //     ? Transform.scale(
        //         scale: value.clamp(0.86, 1.0),
        //         child: child,
        //       )
        //     : child;

        return UniversalPlatform.isAndroid || UniversalPlatform.isIOS
            ? isAninmate
                ? Transform.scale(
                    scale: value.clamp(0.9, 1.0),
                    child: child,
                  )
                : child
            : isAninmate
                ? Transform.translate(
                    offset: Offset(0.0, (1 - value) * -100),
                    child: child,
                  )
                : child;
      },
      child: Card(
        elevation: 8,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              SimplePageRoute(
                builder: (ctx) => CountryCovidStatusDetails(
                  countryStatus: countryStatus,
                ),
                duration: const Duration(milliseconds: 600),
              ),
            );
          },
          leading: Hero(
            tag: countryStatus.countryName ??
                ValueKey(countryStatus.countryFlag),
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1.0, 4.0),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: UniversalPlatform.isLinux
                    ? CachedNetworkImageBuilder(
                        key: countryStatus.countryName != null
                            ? ValueKey(countryStatus.countryName)
                            : ValueKey(countryStatus.countryFlag),
                        url: countryStatus.countryFlag,
                        builder: (image) {
                          return Image.file(
                            image,
                            fit: BoxFit.fill,
                          );
                        },
                        placeHolder: Center(
                          child: SpinKitPulse(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: countryStatus.countryFlag,
                        cacheKey: countryStatus.countryName ??
                            countryStatus.countryFlag,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return LinearProgressIndicator(
                            color: Theme.of(context).accentColor,
                            value: downloadProgress.progress,
                          );
                        },
                      ),
              ),
            ),
          ),
          title: counter == null
              ? Text(
                  countryStatus.countryName +
                      "(" +
                      (countryStatus.countryCode ?? "No Code") +
                      ")",
                  overflow: TextOverflow.ellipsis,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        countryStatus.countryName +
                            "(" +
                            (countryStatus.countryCode ?? "No Code") +
                            ")",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Chip(
                      label: Text(
                        (counter + 1).toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
          subtitle: sortingType == SortingType.active
              ? Text(appLang['activecases'] +
                  " - " +
                  countryStatus.active.toString())
              : Text(appLang['totalcases'] +
                  " - " +
                  countryStatus.cases.toString()),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
