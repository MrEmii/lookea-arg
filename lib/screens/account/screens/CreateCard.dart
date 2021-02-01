import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookea/providers/CardProvider.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/dual_widget.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class CreateCardScreen extends StatefulWidget {

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {

    CardProvider provider = Provider.of<CardProvider>(context);

    return Scaffold(
      appBar: AppHeader(
        backgroundColor: LColors.black9,
        title: "Agregar tarjeta",
        textStyle: TextStyle(fontSize: 14, color: Colors.white),
        leadingIcon: Icon(LIcons.angle_left, color: Colors.white,),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: provider.formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  FlipCard(
                    key: cardKey,
                    flipOnTouch: false,
                    front: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                      decoration: BoxDecoration(
                        color: LColors.black9,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(provider.cardController.text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 9, letterSpacing: 4),),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(provider.namedCardController.text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(provider.expireController.text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                    ),
                    back: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 60),
                      decoration: BoxDecoration(
                        color: LColors.black9,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(provider.ccvController.text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 4),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextInputComponent(
                    onTap: () {
                      if (!cardKey.currentState.isFront) cardKey.currentState.toggleCard();
                    },
                    controller: provider.cardController,
                    placeholder: "0000 0000 0000 0000",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    inputFormatters: [
                      MaskedInputFormater('#### #### #### ####'),
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]"))
                    ],
                    onChanged: (string) {
                      provider.notify();
                    },
                    type: TextInputType.number,
                    validator: (card){
                      if(card == null || card.isEmpty) return "Faltaron los números de la tarjeta!";
                      if(card.replaceAll(" ", "").length != 16 || !isCardValidNumber(card)) return "La tarjeta no es válida";
                    },
                  ),
                  TextInputComponent(
                    onTap: () {
                      if (!cardKey.currentState.isFront) cardKey.currentState.toggleCard();
                    },
                    controller: provider.namedCardController,
                    placeholder: "Nombre y apellido en tarjeta",
                    margin: EdgeInsets.symmetric(vertical: 10),
                    onChanged: (string) {
                      provider.notify();
                    },
                    validator: (name){
                      if(name == null || name.isEmpty) return "Faltó el nombre y apellido!";
                    },
                  ),
                  DualWidget(
                    left: TextInputComponent(
                      onTap: () {
                        if (!cardKey.currentState.isFront) cardKey.currentState.toggleCard();
                      },
                      controller: provider.expireController,
                      placeholder: "04/07",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      inputFormatters: [
                        CreditCardExpirationDateFormatter()
                      ],
                      onChanged: (string) {
                        provider.notify();
                      },
                      type: TextInputType.number,
                      validator: (date){
                        if(date == null || date.isEmpty) return "Falta rellenar";
                      },
                    ),
                    right: TextInputComponent(
                      onTap: () {
                        if (cardKey.currentState.isFront) cardKey.currentState.toggleCard();
                      },
                      controller: provider.ccvController,
                      placeholder: "777",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (string) {
                        provider.notify();
                      },
                      type: TextInputType.number,
                      validator: (ccv){
                        if(ccv == null || ccv.isEmpty) return "Falta rellenar";
                      },
                    ),
                  ),
                  Text("Dirección de facturación"),
                  DualWidget(
                    left: TextInputComponent(
                      controller: provider.streetController,
                      width: MediaQuery.of(context).size.width / 2,
                      placeholder: "Calle",
                      passwordEnabled: false,
                      type: TextInputType.streetAddress,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos tu dirección!";
                        return null;
                      },
                    ),
                    right: TextInputComponent(
                      width: MediaQuery.of(context).size.width / 2,
                      controller: provider.streetNumberController,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      placeholder: "Número de calle",
                      passwordEnabled: false,
                      type: TextInputType.number,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Y el número de calle?";
                        return null;
                      },
                    )
                  ),
                  DualWidget(
                    left: TextInputComponent(
                      controller: provider.countyController,
                      width: MediaQuery.of(context).size.width / 2,
                      placeholder: "Provincia",
                      margin: EdgeInsets.symmetric(vertical: 10),
                      passwordEnabled: false,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Falta tu pronvicia!";
                        return null;
                      },
                    ),
                    right: TextInputComponent(
                      width: MediaQuery.of(context).size.width / 2,
                      controller: provider.cityController,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      placeholder: "Ciudad",
                      passwordEnabled: false,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Y tu ciudad?";
                        return null;
                      },
                    )
                  )
                ],
              ),
            ),
          ),
          Center(
            child: ButtonComponent(
              onTap: () async{
                if (!cardKey.currentState.isFront) cardKey.currentState.toggleCard();
                if(provider.formKey.currentState.validate()){

                }
              },
              margin: EdgeInsets.only(bottom: 20, top: 10),
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 14),
              text: Text("Agregar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          )
        ],
      )
   );
  }
}