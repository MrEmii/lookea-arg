import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';


class SuccessRecoveryPage extends StatelessWidget {

  String email;

  SuccessRecoveryPage({this.email});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/mail/success.png"),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("¡Perfecto!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: LColors.black9),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Hemos enviado un correo a $email revisalo para seguir los pasos!", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: LColors.black9)),
                    )
                  ],
                )
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonComponent(
                    height: 60,
                    onTap: () async{
                      Navigator.pushNamedAndRemoveUntil(context, "/startup", (Route<dynamic> route) => false);
                    },
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width / 1.8,
                    text: Text("Volver al inicio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
   );
  }
}