import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './global_cases_dashboard.dart';

class GlobalCaseCard extends StatefulWidget {
  @override
  _GlobalCaseCardState createState() => _GlobalCaseCardState();
}

class _GlobalCaseCardState extends State<GlobalCaseCard>
    with SingleTickerProviderStateMixin {
  AnimationController _rotationAnimationListener;

  @override
  void initState() {
    _rotationAnimationListener = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 2.0,
    );
    super.initState();
  }

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
              child: OutlinedButton.icon(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                ),
                onPressed: () {
                  setState(() {});
                },
                // the parent is already stateful and for that
                // we use AnimatedBuilder to performace optimization
                icon: AnimatedBuilder(
                  animation: _rotationAnimationListener,
                  builder: (ctx, child) {
                    return Transform.rotate(
                      angle: (pi * 2) * _rotationAnimationListener.value,
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.rotate_right,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                label: Text(
                  "Refresh Cases",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
