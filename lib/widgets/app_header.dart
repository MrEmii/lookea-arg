import 'package:flutter/material.dart';
import 'package:lookea/widgets/LIcons.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Widget titleWidget;
  final TextStyle textStyle;
  final PreferredSizeWidget bottom;
  final Color backgroundColor;
  final Function onTapPop;
  final bool center;
  final Widget leading;
  List<Widget> actions = [];
  final double height;
  Icon leadingIcon;

  AppHeader({this.title, this.bottom, this.backgroundColor, this.onTapPop, this.center = false, this.leading, this.actions, this.height = 60, this.titleWidget, this.textStyle, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(14))
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: this.center,
        bottom: this.bottom ?? null,
        actions: this.actions,
        leading: this.leading ?? IconButton(icon: leadingIcon??Icon(LIcons.angle_left), onPressed: () => Navigator.pop(context)),
        title: this.titleWidget ??  new Text(title ?? "", style: textStyle ?? AppBarTheme.of(context).textTheme.title,)
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}