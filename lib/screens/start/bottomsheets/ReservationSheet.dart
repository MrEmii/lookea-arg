import 'package:flutter/material.dart';
import 'package:lookea/models/reservation_model.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/cached_image.dart';


class ReservationBottomSheet extends StatelessWidget {

  ReservationModel model;

  ReservationBottomSheet(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LColors.black9,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26))
      ),
      child: FutureBuilder<ShopModel>(
        future: FirebaseUtils.getShop(model.shopId.split("||")[0]),
        builder: (_, snapshot){
          if(snapshot.hasData){
            ShopModel model = snapshot.data;

            String avaiableString = model.available.join(", ");

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: CachedImage(
                    url: model.images[0],
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        LColors.black9.withOpacity(0.5),
                        LColors.black9
                      ],
                    ),
                    placeholder: Container(
                      width: 50,
                      height: 50,
                      child: Center(child: CircularProgressIndicator(),),
                    ),
                    error: Container(
                      child: Center(child: Text(model.alias),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(model.alias, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),),
                      Text(model.address, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                      Text("Abierto ${model.available.length == 7 ?  "todos los días" : "los días " + avaiableString.replaceFirst("," , " y", avaiableString.lastIndexOf(",")-1)} de ${model.from.substring(0, 5)} hasta las ${model.at.substring(0, 5)}", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonComponent(
                      onTap: () => Navigator.pushNamed(context, "/shop", arguments: model),
                      height: 60,
                      background: LColors.gray2,
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 1.8,
                      text: Text("Abrir chat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    )
                  ),
                )
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}