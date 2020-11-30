import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';

import 'package:lookea/widgets/cached_image.dart';

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

    String avaiableString = widget.model.available.join(", ");

    return GestureDetector(
      onLongPress: widget.onLongPress ?? () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                color: LColors.black9,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: CachedImage(
                      url: widget.model.images[0],
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          LColors.black9.withOpacity(0.5),
                          LColors.black9
                        ],
                      ),
                      placeholder: Container(
                        width: 50,
                        height: 50,
                        child: Center(child: CircularProgressIndicator(),),
                      ),
                      error: Container(
                        child: Center(child: Text(widget.model.alias),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.model.alias, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),),
                        Text(widget.model.address, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                        Text("Abierto ${widget.model.available.length == 7 ?  "todos los días" : "los días " + avaiableString.replaceFirst("," , " y", avaiableString.lastIndexOf(",")-1)} de ${widget.model.from.substring(0, 5)} hasta las ${widget.model.at.substring(0, 5)}", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonComponent(
                        onTap: () => Navigator.pushNamed(context, "/shop", arguments: widget.model),
                        height: 60,
                        background: LColors.gray2,
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.8,
                        text: Text("Ver más", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      )
                    ),
                  )
                ],
              ),
            );
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