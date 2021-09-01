import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import 'line_chart.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final int cases;
  final Color iconColor;
  final Color titleColor;

  const InfoCard({
    Key key,
    this.title,
    this.titleColor,
    this.cases,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () {},
              child: AnimatedOpacity(
                opacity: value.clamp(0.1, 1.0),
                duration: const Duration(milliseconds: 400),
                child: Transform.translate(
                  offset: Offset(0.0, 40 * (1 - value)),
                  child: child,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4,
            child: Container(
              width: constraints.maxWidth / 2 - 10,
              // width: 300,
              // Here constraints.maxWidth provide us the available width for the widget
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          // wrapped within an expanded widget to allow for small density device
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: iconColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/running.svg",
                                height: 16,
                                width: 16,
                                color: iconColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: TextStyle(
                              color: titleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: kTextColor),
                                children: [
                                  TextSpan(
                                    text: "$cases \n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  TextSpan(
                                    text: "People",
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 2,
                                      color: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: LineReportChart(iconColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
