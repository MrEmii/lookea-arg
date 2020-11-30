import 'package:flutter/material.dart';
import 'package:lookea/widgets/LIcons.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Widget titleWidget;
  final PreferredSizeWidget bottom;
  final Color backgroundColor;
  final Function onTapPop;
  final bool center;
  final Widget leading;
  List<Widget> actions = [];
  final double height;

  AppHeader({this.title, this.bottom, this.backgroundColor, this.onTapPop, this.center = false, this.leading, this.actions, this.height = 60, this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: this.backgroundColor ?? Colors.white,
      centerTitle: this.center,
      bottom: this.bottom ?? null,
      actions: this.actions,
      leading: this.leading ?? IconButton(icon: Icon(LIcons.angle_left), onPressed: () => Navigator.pop(context)),
      title: this.titleWidget ??  new Text(title ?? "")
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}