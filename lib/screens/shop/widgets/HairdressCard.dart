import 'package:flutter/material.dart';
import 'package:lookea/models/hairdresser_model.dart';
import 'package:lookea/widgets/LColors.dart';

class HairdressCard extends StatelessWidget {
  HairDresseModel model;

  HairdressCard({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        width: 120,
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: LColors.black9,
          image: DecorationImage(image: NetworkImage(model.image), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 4
            )
          ]
        ),
      ),
    );
  }
}