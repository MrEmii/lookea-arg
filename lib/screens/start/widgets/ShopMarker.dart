import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';

class ShopMarker extends StatefulWidget {

  final int shopType;
  final Function onTap;
  bool isOpen;

  ShopMarker({this.shopType, this.onTap, this.isOpen});

  @override
  _ShopMarkerState createState() => _ShopMarkerState();

}

class _ShopMarkerState extends State<ShopMarker> {
  
  List<IconData> icons = [LIcons.razor, LIcons.scissors, LIcons.hair_dryer];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isOpen ? LColors.green3 : LColors.red37,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: widget.isOpen ? LColors.green3 : LColors.red37, blurRadius: 10.0)
          ]
        ),
        child: Icon(icons[this.widget.shopType], size: 19,),
      ),
    );
  }
}