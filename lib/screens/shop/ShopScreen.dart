import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/screens/shop/widgets/HairdressCard.dart';
import 'package:lookea/screens/start/widgets/SliverPersistent.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:url_launcher/url_launcher.dart';


class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  List<String> shopTypes = ["Barberia", "Peluqueria", "Estilista"];
  ScrollController mainController = ScrollController();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ShopModel model = ModalRoute.of(context).settings.arguments;
    String avaiableString = model.available.join(", ");
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(LIcons.angle_left, color: Colors.white,),
        ),
        title: Text(shopTypes[model.type], style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: LColors.black9.withOpacity(0.5),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: PersistentHeaderDelegate(
              minExtends: 86,
              maxExtents: 250,
              child: Hero(
                tag: 'shop-'+model.alias,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 50),
                  height: 250,
                  decoration: BoxDecoration(
                    color: LColors.black9,
                    image: DecorationImage(image: NetworkImage(model.images[0]), fit: BoxFit.cover),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 4
                      )
                    ]
                  ),
                ),
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.alias, textAlign: TextAlign.left, style: TextStyle( fontSize: 26, fontWeight: FontWeight.bold),),
                  Text(model.address, textAlign: TextAlign.left, style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600),),
                  Text("Abierto ${model.available.length == 6 ?  "todos los días" : "los días " + avaiableString.replaceFirst("," , " y", avaiableString.lastIndexOf(",")-1)} de ${model.from.substring(0, 5)} hasta las ${model.at.substring(0, 5)}", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: GestureDetector(
                      onTap: () => navigateTo(model.address),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height:100,
                          decoration: BoxDecoration(
                            color: LColors.black9,
                            image: DecorationImage(image: AssetImage("assets/images/map.jpg"), fit: BoxFit.cover),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              color: Colors.black.withOpacity(0.51),
                              child: Center(child: Text("Ver ${model.alias} en maps", style: TextStyle(color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text("Estilos para vos", style: TextStyle( fontSize: 20))
                ],
              ),
            ),
          ),
          SliverGrid.count(crossAxisCount: (MediaQuery.of(context).size.width / 120).floor(), mainAxisSpacing: 20, children: List.generate(8, (index) => null).map((e) => HairdressCard(model: model.hairdress[0],)).toList(),),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text("Clientes satisfechos", style: TextStyle( fontSize: 20)),
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (_, index) =>  HairdressCard(model: model.hairdress[0])
                ),
              )
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(LIcons.ticket),
        label: Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
        onPressed: () => Navigator.pushNamed(context, "/shop/reservation"),
      ),
    );
  }

  void navigateTo(address) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$address';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}