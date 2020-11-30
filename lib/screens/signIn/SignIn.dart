import 'package:flutter/material.dart';
import 'package:lookea/providers/NotificationsProvider.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'dart:ui' as ui;

import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/Waves.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }


  bool isEmail(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    SignInProvider provider = Provider.of(context);
    PushNotificationProvider pushNotificationProvider = Provider.of<PushNotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LColors.black9,
        toolbarHeight: 0,
        leading: Container(),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              CustomPaint(
                size: new Size(MediaQuery.of(context).size.width, 200),
                painter: WaveTop(),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text("Ingresá", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600),),
              )
            ],
          ),
          Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputComponent(
                      autocorrect: false,
                      controller: provider.emailController,
                      width: MediaQuery.of(context).size.width / 1.3,
                      placeholder: "Correo",
                      passwordEnabled: false,
                      type: TextInputType.emailAddress,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      capitalization: TextCapitalization.none,
                      autoFocus: true,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos tu correo!";
                        if(!isEmail(mail))
                          return "El correo no es correcto";
                        return null;
                      },
                      placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18)
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Olvidé mi contraseña", style: TextStyle(color: LColors.gray50, fontSize: 12))
                    ),
                    TextInputComponent(
                      controller: provider.passwordController,
                      placeholder: "Contraseña",
                      width: MediaQuery.of(context).size.width / 1.3,
                      passwordEnabled: true,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos tu contraseña!";
                        return null;
                      },
                      placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
                    ),
                  ],
                ),
                ButtonComponent(
                  onTap: () async{
                    if(provider.formKey.currentState.validate()){
                      OverlayUtils.showLoading(context);

                      String result =  await provider.login();
                      if(result != ""){
                        Navigator.pop(context);
                        OverlayUtils.showAlert(context, description: result, dismissible: true);
                      }else{
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/");
                        provider.reset();
                        pushNotificationProvider.initNotifications();
                      }

                    }
                  },
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 1.8,
                  text: Text("Ingresar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          )
        ],
      ),
   );
  }
}