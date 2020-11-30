import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';


class ButtonComponent extends StatelessWidget {

  final Widget child;
  final Color background;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final Function onTap;
  final Widget text;
  final double width;
  final double height;
  final List<BoxShadow> boxShadow;

  ButtonComponent({this.child, this.text, this.background, this.padding, this.margin, this.borderRadius, this.onTap, this.width, this.height, this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){},
      child: this.child ?? Container(
        width: this.width ?? 100,
        height: this.height ?? null,
        padding: this.padding ?? EdgeInsets.all(10),
        margin: this.margin ?? EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: this.borderRadius ?? BorderRadius.circular(10),
          boxShadow: this.boxShadow ?? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4
            )
          ],
          color: this.background ?? LColors.black9
        ),
        child: this.text
      )
    );
  }
}