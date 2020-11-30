import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lookea/models/shop_model.dart';


class MainProvider extends ChangeNotifier{


  TextEditingController homeSearchController = TextEditingController(text: "");
  int currentTab = 0;

  Map<String, List<ShopModel>> shops = {
    "0": [],
    "1": [],
    "2": []
  };

  Map<String, List<ShopModel>> proximityShops = {
    "0": [],
    "1": [],
    "2": []
  };


  static var _locJSON = [
  {
    "address": "Nápoles 3766, San Miguel, Buenos Aires, Argentina",
    "alias": "Lam-plex",
    "at": "05:03:22.387216",
    "from": "03:06:29.387703",
    "available": ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"],
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 1,
    "lat": -34.5543931,
    "long": -58.744846900000006
  },
  {
    "available": ["Lunes", "Martes", "Miercoles"],
    "address": "Salerno 3449, San Miguel, Buenos Aires, Argentina",
    "alias": "Transnamtechno",
    "at": "18:39:20.387419",
    "from": "16:58:50.387838",
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 1,
    "lat": -34.54960760000001,
    "long": -58.74458979999999
  },
  {
    "available": ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
    "address": "Intendente Arricau 4070, San Miguel, Buenos Aires, Argentina",
    "alias": "Con-strip",
    "at": "18:28:47.387504",
    "from": "06:55:36.387922",
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 0,
    "lat": -34.550147599999995, "long": -58.7553284

  },
  {
    "address": "Pichincha 3004, San Miguel, Buenos Aires, Argentina",
    "alias": "Lam-asdaw",
    "at": "05:03:22.387216",
    "from": "03:06:29.387703",
    "available": ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"],
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 2, "lat": -34.551822699999995, "long": -58.74890129999999

  },
  {
    "available": ["Lunes", "Martes", "Miercoles"],
    "address": "Maestro Sarmiento 3043, San Miguel, Buenos Aires, Argentina",
    "alias": "aaaadf",
    "at": "18:39:20.387419",
    "from": "16:58:50.387838",
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 0,
    "lat": -34.548254799999995, "long": -58.74572190000001

  },
  {
    "available": ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
    "address": "Alexander Fleming 3691, San Miguel, Buenos Aires, Argentina",
    "alias": "dsad-strip",
    "at": "18:28:47.387504",
    "from": "06:55:36.387922",
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 0,
    "lat": -34.565479499999995, "long": -58.728322999999996

  },
  {
    "available": ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
    "address": "Alexander Fleming 3691, San Miguel, Buenos Aires, Argentina",
    "alias": "dasddddd-strip",
    "at": "18:28:47.387504",
    "from": "06:55:36.387922",
    "hairdress": [
      {
        "description": "description",
        "image": "https://instagram.faep10-1.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/p640x640/124288946_799981497235754_3946732440877601169_n.jpg?_nc_ht=instagram.faep10-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=THNAVxZG-GgAX-ymy6Z&_nc_tp=24&oh=d27bfe7765a0b6cba41e63a27be720f0&oe=5FD5EB19",
        "name": "name",
        "price": 10,
        "style": "style"
      }
    ],
    "images": [
      "https://i.pinimg.com/originals/43/7e/df/437edf96d102a55cd0cfb8809c12b39b.jpg"
    ],
    "type": 0,
    "lat": -34.565479499999995, "long": -58.728322999999996

  },
];

  static List<ShopModel> parseOptions(toParse){
    return toParse.map<ShopModel>((element) => ShopModel.fromJson(element)).toList();
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
    List<ShopModel> models = await compute(parseOptions, _locJSON);
    for (ShopModel model in models){
      this.shops["${model.type}"].add(model);
    }

    List<ShopModel> proximityModels = await this.filterByProximity(models);
    for (ShopModel model in proximityModels){
      this.proximityShops["${model.type}"].add(model);
    }
    return;
  }

  void notify(){
      notifyListeners();
  }
}