import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class AppBarAccountDelegate extends SliverPersistentHeaderDelegate {
  static const TAG = 'AppBarAccount';

  final double topPadding;
  final VoidCallback onShowMenu;

  AppBarAccountDelegate(this.topPadding, this.onShowMenu);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    developer.log('build [$context, $shrinkOffset, $overlapsContent]',
        name: TAG);
    return Material(
      color: Colors.black,
      child: Container(
        height: kToolbarHeight + topPadding,
        padding: EdgeInsets.only(top: topPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: <Widget>[
                  Text(
                    'phantomkhs',
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: onShowMenu,
            )
          ],
        ),
      ),
      elevation:
          (overlapsContent || (shrinkOffset > maxExtent - minExtent)) ? 4 : 0,
    );
  }

  @override
  double get maxExtent => kToolbarHeight + topPadding;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
