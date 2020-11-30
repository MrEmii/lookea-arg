import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/screens/start/widgets/ShopCard.dart';
import 'package:lookea/screens/start/widgets/ShopMarker.dart';
import 'package:lookea/screens/start/widgets/SliverPersistent.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:intl/intl.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/cached_image.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}
extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin{

  final MapController mapController = MapController();
  List<Marker> result = [];


  void markers(MainProvider provider) async{
    List<Marker> stresult = [];
    List<String> days = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];

    for (ShopModel element in provider.proximityShops.values.expand((element) => element).toList()) {
      var long = element.long;
      var lat = element.lat;
      DateTime now = DateTime.now();
      DateTime timeAt = DateFormat("Hms").parse(element.at).copyWith(day: now.day, month: now.month, year: now.year);
      DateTime timeFrom = DateFormat("Hms").parse(element.from).copyWith(day: now.day, month: now.month, year: now.year);
      String avaiableString = element.available.join(", ");

      bool isOpen = element.available.contains(days[now.weekday - 1]) && now.isAfter(timeFrom) && now.isBefore(timeAt);

      Marker marker = Marker(
        width: 30.0,
        height: 30.0,
        point: new LatLng(lat, long),
        builder: (ctx) {
          return ShopMarker(
            shopType: element.type,
            isOpen:  isOpen,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: LColors.black9,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(26))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 21/9,
                          child: CachedImage(
                            url: element.images[0],
                            borderRadius: BorderRadius.circular(15),
                            placeholder: Container(
                              width: 50,
                              height: 50,
                              child: Center(child: CircularProgressIndicator(),),
                            ),
                            error: Container(
                              child: Center(child: Text(element.alias),),
                            ),
                          ),
                        ),
                        Text(element.alias, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),),
                        Text(element.address, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                        Text("Abierto ${element.available.length == 7 ?  "todos los días" : "los días " + avaiableString.replaceFirst("," , " y", avaiableString.lastIndexOf(",")-1)} de ${element.from.substring(0, 5)} hasta las ${element.at.substring(0, 5)}", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                        if(isOpen)
                          Expanded(child: Center(
                            child: ButtonComponent(
                              onTap: () {},
                              background: LColors.gray2,
                              margin: EdgeInsets.all(40),
                              width: MediaQuery.of(context).size.width / 1.8,
                              text: Text("Ver más", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            )
                          ))
                        else
                          Expanded(child: Center(child: Text("CERRADO", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),)))
                      ],
                    ),
                  );
                }
              );
            },
          );
        }
      );
      stresult.add(marker);
    }

    setState(() {
      this.result = stresult;
    });


  }

  @override
  void initState() {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    markers(provider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Position> position = Geolocator.getLastKnownPosition();

    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    return FutureBuilder(
      future: position,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return Stack(
            children: [
              FlutterMap(
                mapController: this.mapController,
                options: MapOptions(
                  center: new LatLng(snapshot.data.latitude, snapshot.data.longitude),
                  zoom: 17.0,
                  maxZoom: 17,
                  minZoom: 12
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    retinaMode: false
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 10.0,
                        height: 10.0,
                        point: new LatLng(snapshot.data.latitude, snapshot.data.longitude),
                        builder: (ctx) {
                          return Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(color: Colors.blueAccent, blurRadius: 10.0)
                            ]),
                          );
                        }
                      ),
                      ...result
                    ]
                  )
                ]
              ),

              Positioned.fill(
                child: DraggableScrollableActuator(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.25,
                    builder: (sheetContext, controller){
                      return ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
                        child: Container(
                          color: LColors.black9,
                          padding: EdgeInsets.only(bottom: 60),
                          child: CustomScrollView(
                            controller: controller,
                            slivers: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: true,
                                delegate: PersistentHeaderDelegate(
                                  maxExtents: 100,
                                  minExtends: 100,
                                  child: Container(
                                    color: LColors.black9,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 40,
                                              height: 2,
                                              color: LColors.gray3,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextInputComponent(
                                          placeholder: "Busca por dirección",
                                          width: MediaQuery.of(context).size.width,
                                          suffixIcon: Icon(LIcons.search, size: 18,),
                                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          onSubmit: (submit) {
                                            print(submit);
                                          },
                                          validator: (mail) {
                                            return null;
                                          },
                                        )

                                      ],
                                    ),
                                  )
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  provider.shops.values.expand((element) => element).toList().map((e) => ShopCard(
                                    model: e,
                                    onLongPress: () {},
                                    onTap: () {
                                      mapController.move(LatLng(e.lat, e.long), 17.0);
                                      bool t = DraggableScrollableActuator.reset(sheetContext);
                                      print(t);
                                    },)
                                  ).toList()
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              )
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
        }
      },
    );
  }
}