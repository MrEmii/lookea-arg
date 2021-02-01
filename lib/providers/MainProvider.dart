import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/models/reservation_model.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:intl/intl.dart';
import 'package:lookea/utils/firebase_utils.dart';

class MainProvider extends ChangeNotifier{

  TextEditingController homeSearchController = TextEditingController(text: "");
  int currentTab = 0;

  Map<String, List<ShopModel>> shops = {
    "0": [],
    "1": [],
    "2": []
  };
  Map<String, List<ReservationModel>> reservations = {};
  Map<String, List<ShopModel>> proximityShops = {
    "0": [],
    "1": [],
    "2": []
  };

  static List<String> meses = ["enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"];
  static List<String> days = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];

  static Map<String, List<ReservationModel>> parseReservations(reservations){

    Map<String, List<ReservationModel>> resbkp = {};

    for(ReservationModel model in reservations){
      DateTime time = DateFormat("dd/MM/yyyy HH:mm").parse(model.dateTime);
      if(resbkp[meses[time.month - 1 ]] == null){
        resbkp[meses[time.month - 1]] = new List();
      }
      resbkp[meses[time.month - 1]].add(model);
    }
    return resbkp;
  }

  Future<List<ShopModel>> filterByProximity(List<ShopModel> models) async {
    List<ShopModel> _tmpMarkers = List();

    var userPosition = await Geolocator.getLastKnownPosition();
    var ulong = userPosition.longitude;
    var ulat = userPosition.latitude;

    for (int i = 0; i < models.length; ++i) {

      ShopModel element = models[i];

      try{
        double calcDist = Geolocator.distanceBetween(ulat, ulong, element.lat, element.long);

        if (calcDist / 1000 < 3) {
          _tmpMarkers.add(element);
        }
      }catch(pe){
        print("========== ERROR DE GPS ${element.alias} ========");
        print(pe);
      }
    }
    return Future.value(_tmpMarkers);
  }

  Stream<String> searchShops() async*{
    if(this.shops["0"].isEmpty && this.shops["1"].isEmpty && this.shops["2"].isEmpty) {
      await updateShops();
      yield "";
    }
    yield "";
  }

  Future<void> updateShops() async{
    List<ShopModel> models = await FirebaseUtils.getShops();
    this.shops["0"].clear();
    this.shops["1"].clear();
    this.shops["2"].clear();

    this.proximityShops["0"].clear();
    this.proximityShops["1"].clear();
    this.proximityShops["2"].clear();
    for (ShopModel model in models){
      this.shops["${model.type}"].add(model);
    }

    List<ShopModel> proximityModels = await this.filterByProximity(models);
    for (ShopModel model in proximityModels){
      this.proximityShops["${model.type}"].add(model);
    }
    return;
  }

  Future<List<dynamic>> updateReservations() async{
    List<Map<String, dynamic>> res = [];
    if(this.reservations.isEmpty){
      this.reservations = await compute(parseReservations, LocalData.user.reservations);
    }

    for(MapEntry<String, List<ReservationModel>> r in this.reservations.entries){
      for(ReservationModel model in r.value){
        res.add({'group': r.key, 'model': model});
      }
    }

    return Future.value(res);
  }

  void notify(){
      notifyListeners();
  }
}