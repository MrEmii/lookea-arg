import 'package:lookea/models/hairdresser_model.dart';
class ShopModel {

   final String alias;
   final String at;
   final List<dynamic> available;
   final String from;
   final List<HairDresseModel> hairdress;
   final List<dynamic> images;
   final String address;
   final int type;

   final double lat;
   final double long;

  ShopModel({this.alias, this.at, this.available, this.from, this.hairdress, this.images, this.address, this.type, this.lat, this.long});

  factory ShopModel.fromJson(Map<String, dynamic> model) {
    return ShopModel(
    alias: model["alias"],
    at: model["at"],
    from: model["from"],
    available: model["available"],
    hairdress: model["hairdress"].map<HairDresseModel>((t) => HairDresseModel.fromJson(t)).toList(),
    images: model["images"],
    address: model["address"],
    type: model["type"],
    lat: model["lat"],
    long: model["long"]
  );
  }

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "at": at,
    "from": from,
    "hairdress": hairdress.map((e) => e.toJson()).toList(),
    "images": images,
    "address": address,
    "type": type,
    "available": available,
    "lat": lat,
    "long": long
  };

}