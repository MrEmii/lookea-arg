import 'package:flutter/material.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:provider/provider.dart';


class AccountCreatedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SignUpProvider provider = Provider.of<SignUpProvider>(context);
    SignInProvider signInProvider = Provider.of<SignInProvider>(context);

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
                      image: AssetImage("assets/images/user/success.png"),
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("Perfecto!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: LColors.black9),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Tu cuenta fue registrada con exito revisa tu correo para verificar tu cuenta!", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: LColors.black9)),
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
                      provider.reset();
                      OverlayUtils.showLoading(context);
                      bool result = await signInProvider.authenticate();
                      if(result){
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
                      }else{
                        FirebaseUtils.logout();
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("No pudimos autenticarte, proba iniciando sesión")));
                        Navigator.pushNamedAndRemoveUntil(context, "/startup", (Route<dynamic> route) => false);

                      }
                    },
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width / 1.8,
                    text: Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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