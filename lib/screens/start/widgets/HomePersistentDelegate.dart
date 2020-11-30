import 'package:flutter/material.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/cached_image.dart';

class HomePersistentHeaderDelegate extends SliverPersistentHeaderDelegate{

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(LIcons.align_left, color: LColors.black9,), onPressed: () => Navigator.pushNamed(context, "/account")),
              IconButton(icon: Icon(LIcons.bell, color: LColors.black9,), onPressed: () => Navigator.pushNamed(context, "/notifications"))
            ],
          ),
          CachedImage(
            url: LocalData.user.photoUrl,
            width: 40,
            height:  40,
            borderRadius: BorderRadius.circular(15),
            placeholder: Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
            errorImg: "assets/images/user/avatar.png",
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}