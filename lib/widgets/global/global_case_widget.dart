import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import './global_cases_dashboard.dart';

class GlobalCaseCard extends StatefulWidget {
  @override
  _GlobalCaseCardState createState() => _GlobalCaseCardState();
}

class _GlobalCaseCardState extends State<GlobalCaseCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cst) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: cst.maxHeight * 0.9,
              child: GlobalCasesDashboard(),
            ),
            Container(
              height: cst.maxHeight * 0.1,
              child: RaisedButton.icon(
                onPressed: () {
                  setState(() {});
                },
                color: kPrimaryColor,
                icon: Icon(
                  Icons.rotate_right,
                  color: Colors.white,
                ),
                label: Text(
                  "Refresh Cases",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
