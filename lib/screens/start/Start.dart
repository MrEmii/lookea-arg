import 'package:flutter/material.dart';
import 'package:lookea/screens/start/views/Home.dart';
import 'package:lookea/screens/start/views/Map.dart';
import 'package:lookea/screens/start/views/Reservation.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/gradient_widget.dart';


class StartScreen extends StatefulWidget {

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin{

  TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget homeBottomBar(){
    return TabBar(
      onTap: (index){
        this.setState(() {
          currentIndex = index;
        });
      },
      isScrollable: false,
      labelColor: Colors.white,
      controller: tabController,
      labelStyle: TextStyle(
        fontSize: 10,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide.none,
        insets: EdgeInsets.zero
      ),
      tabs: <Widget>[
        GradientComponent(
          gradient: currentIndex == 0 ? LColors.blackGradient : LColors.translucentGradient,
          child: Tab(
            icon: Icon(LIcons.shop, size: currentIndex == 0 ? 20 : 18,),
            iconMargin: EdgeInsets.all(0),
            text: "Locales",
          ),
        ),
        GradientComponent(
          gradient: currentIndex == 1 ? LColors.blackGradient : LColors.translucentGradient,
          child: Tab(
            icon: Icon(LIcons.map, size:  currentIndex == 1? 20 : 18,),
            iconMargin: EdgeInsets.all(0),
            text: "Mapa",
          ),
        ),
        GradientComponent(
          gradient: currentIndex == 2 ? LColors.blackGradient : LColors.translucentGradient,
          child: Tab(
            icon: Icon(LIcons.calendar_alt, size:  currentIndex == 2 ? 20 : 18,),
            iconMargin: EdgeInsets.all(0),
            text: "Reservas",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: TabBarView(
                    controller: tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      HomeScreen(),
                      MapScreen(),
                      ReservationScreen()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: LColors.black9,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                    ),
                    child: homeBottomBar(),
                  )
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}