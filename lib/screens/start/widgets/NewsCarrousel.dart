import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';

class NewsCarrousel extends StatefulWidget {
  NewsCarrousel();

  @override
  _NewsCarrouselState createState() => _NewsCarrouselState();
}

class _NewsCarrouselState extends State<NewsCarrousel> {

  PageController _controller = PageController(
    keepPage: false,
  );

  Timer timer;
  int _index = 0;

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      onPageChanged: (i) {
        print("index");
      },
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 120,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LColors.azurLane,
            borderRadius: BorderRadius.circular(14)
          ),
          child: Center(child: Text("1")),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 120,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LColors.gradientLove,
            borderRadius: BorderRadius.circular(14)
          ),
          child: Center(child: Text("2")),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 120,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LColors.citrusPeel,
            borderRadius: BorderRadius.circular(14)
          ),
          child: Center(child: Text("3")),
        )
      ],
    );
  }

  @override
  void didUpdateWidget(covariant NewsCarrousel oldWidget) {
    print("UPDATE");
    super.didUpdateWidget(oldWidget);
  }
}
