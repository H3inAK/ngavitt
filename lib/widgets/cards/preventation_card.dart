import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: SvgPicture.asset(
              svgSrc,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
