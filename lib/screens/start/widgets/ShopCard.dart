import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/screens/start/bottomsheets/ShopSheet.dart';
import 'package:lookea/widgets/LColors.dart';

class ShopCard extends StatefulWidget {


  final Function onTap;
  final ShopModel model;
  final Function onLongPress;

  const ShopCard({Key key, this.model, this.onTap, this.onLongPress}) : super(key: key);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onLongPress: widget.onLongPress ?? () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return ShopBottomSheet(widget.model);
          }
        );
      },
      onTap: widget.onTap ?? () => Navigator.pushNamed(context, "/shop", arguments: widget.model),
      child: Container(
        height: 151,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: LColors.black9,
          image: DecorationImage(image: CachedNetworkImageProvider(widget.model.images[0]), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 4
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      LColors.black9,
                      Colors.transparent
                    ]
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.model.alias, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                    Text(widget.model.address, textAlign: TextAlign.start, style: TextStyle(color: LColors.white19, fontSize: 14, fontWeight: FontWeight.w500),),
                  ]
                ) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}