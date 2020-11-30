import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/models/payment_model.dart';
import 'package:lookea/screens/account/screens/CreateCard.dart';
import 'package:lookea/screens/account/widgets/PaymentCard.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:lookea/widgets/button.dart';


class PaymentsMethodsScreen extends StatelessWidget {

  List<IconData> paymentIcons = [
    LIcons.card_atm,
    LIcons.credit_card,
    LIcons.money_bill
  ];

  @override
  Widget build(BuildContext context) {
    List<PaymentModel> payments = LocalData.user.paymentsMethods;
    return Scaffold(
      appBar: AppHeader(
        titleWidget: Text("Métodos de pago", style: TextStyle(fontSize: 14),),
      ),
      body: Column(
        children: [
          Container(
            height: payments.length * 60.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              itemCount: payments.length,
              itemBuilder: (_, index) {
                PaymentModel model = payments[index];
                return PaymentCard(id: model.ccv == 0 ? "Efectivo" : model.numbers.substring(12, 16), icon: paymentIcons[model.paymentType.index], onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  context: context,
                  builder: (_) {
                    return Container(
                      height: 331,
                      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                      ),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/user/bill.png"),
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          SizedBox(height: 20),
                          Text("Método de pago en efectivo", style: TextStyle(color: LColors.black9, fontSize: 18, fontWeight: FontWeight.w600),),
                          SizedBox(height: 10),
                          Text("Aceptamos que pagues en el momento con efectivo, pero acórdate de llevar cambio y monedas", textAlign: TextAlign.center, style: TextStyle(color: LColors.black9),),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ButtonComponent(
                                height: 60,
                                onTap: () => Navigator.pop(context),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                width: MediaQuery.of(context).size.width / 1.8,
                                text: Text("Cerrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ), );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: PaymentCard(
              id: "Agregar una tarjeta",
              icon: LIcons.plus_circle,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CreateCardScreen()));
              },
            ),
          )
        ],
      )
    );
  }
}