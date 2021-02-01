import 'package:flutter/material.dart';
import 'package:lookea/screens/lostpassword/screens/Successrecovery.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/text_input.dart';

class LostPasswordScreen extends StatelessWidget {

  GlobalKey<FormState> emailForm = GlobalKey();
  TextEditingController emailController = TextEditingController();

  bool isEmail(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppHeader(
        title: "Recuperar contraseña",
        textStyle: TextStyle(fontSize: 14),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 39),
        child: Column(
          children: [
            Text("¿Olvidate tú contraseña?", textAlign: TextAlign.center, style: TextStyle(color: LColors.black9, fontWeight: FontWeight.w600, fontSize: 24),),
            Text("Entendemos tu situación y para ayudarte necesitamos solo el correo de la cuenta.", textAlign: TextAlign.center, style: TextStyle(color: LColors.black9, fontSize: 14),),
            SizedBox(height: 20,),
            Form(
              key: emailForm,
              child: TextInputComponent(
                autocorrect: false,
                controller: emailController,
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
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonComponent(
                  height: 60,
                  onTap: () async{
                    if(emailForm.currentState.validate()){
                      OverlayUtils.showLoading(context);
                      String result = await FirebaseUtils.resetPassword(email: this.emailController.text);
                      Navigator.pop(context);
                      if(result.isEmpty){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SuccessRecoveryPage(email: this.emailController.text)), (Route<dynamic> route) => false);
                      }else{
                        OverlayUtils.showAlert(context, description: result, dismissible: true);
                      }

                    }
                  },
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 1.8,
                  text: Text("¡Recuperar contraseña!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ],
        ),
      ),
   );
  }
}