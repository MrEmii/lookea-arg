import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';


class AnimatedCard extends StatefulWidget {

  @override
  _AnimatedCardState createState() => _AnimatedCardState();

}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    animationController.repeat(reverse: true);
    animation = Tween(begin: 0.0, end: 0.4).animate(animationController)..addListener(() {
      setState(() {
        // animate the color
        double index = animation.value * 10;
        bottomColor = colorList[index.toInt() % colorList.length];
        topColor = colorList[(index.toInt() + 1) % colorList.length];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<Color> colorList = [
    Colors.white,
    Color(0xffF6F6F6),
    Color(0xffF0F0F0),
    Color(0xffF6F6F6),
  ];

  Color bottomColor = Colors.white;
  Color topColor = Color(0xffF6F6F6);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 151,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      duration: Duration(seconds: 2),
      curve: Curves.linear,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [bottomColor, topColor])
      ),
    );
  }
}