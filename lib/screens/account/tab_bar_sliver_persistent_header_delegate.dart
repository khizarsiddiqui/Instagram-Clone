import 'package:flutter/material.dart';

class TabBarSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate{
  static const TAG = 'TabBarSliverPersistentHeaderDelegate';

  Widget child;

  TabBarSliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: child,
      color: Colors.black,
      elevation: overlapsContent ? 4 : 0,
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }


}