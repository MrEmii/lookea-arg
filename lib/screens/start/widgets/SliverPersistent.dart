import 'package:flutter/material.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate{

  Widget child;
  double maxExtents;
  double minExtends;

  PersistentHeaderDelegate({this.child, this.maxExtents, this.minExtends});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.maxExtents;

  @override
  // TODO: implement minExtent
  double get minExtent => this.minExtends;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}