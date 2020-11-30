import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/text_input.dart';


class PasswordPage extends StatelessWidget {

  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Necesitamos tu contraseña", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: "Poppins",fontWeight: FontWeight.w600, color: LColors.black9),),
          Text("Para guardar los cambios necesitamos estár seguros de que sos vos el priopitario de la cuenta.", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Poppins", fontSize: 14, color: LColors.black9),),
          Form(
            key: passwordKey,
            child: TextInputComponent(
              controller: passwordController,
              placeholder: "Confirma la contraseña",
              width: MediaQuery.of(context).size.width,
              passwordEnabled: true,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              validator: (mail) {
                if(mail == null || mail.trim().isEmpty)
                  return "Necesitamos tu contraseña!";
                return null;
              },
            ),
          ),
          Expanded(child: SizedBox()),
          ButtonComponent(
            onTap: () {
              if(passwordKey.currentState.validate()){
                Navigator.pop(context, passwordController.text);
              }
            },
            borderRadius: BorderRadius.circular(20),
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            text: Text("Confirmar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}