import 'package:flutter/material.dart';
import 'package:lookea/screens/account/screens/SuccessChange.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:lookea/widgets/text_input.dart';

class PasswordScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nPasswordController = TextEditingController();
  TextEditingController reNPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Edita tu contraseña", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26)),
            Text("una vez que hayas cambiado de contraseña, vas a tener que volver a ingresar!", style: TextStyle(fontWeight: FontWeight.w500)),
            Center(
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: LColors.gray6,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("Olvidé mi contraseña.", style: TextStyle(color: LColors.gray50)),
                ),
              ),
            ),
            Form(
              key: this.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextInputComponent(
                    controller: passwordController,
                    placeholder: "Tu contraseña actual",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: true,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Faltó tu contraseña!";
                      return null;
                    },
                    placeholderStyle: TextStyle(color: LColors.white19, fontSize: 14),
                  ),
                  TextInputComponent(
                    controller: nPasswordController,
                    placeholder: "Nueva contraseña",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: true,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Faltó poner tu nueva contraseña!";
                      if (mail != reNPasswordController.text)
                        return "Las contraseñas no coinciden";
                      return null;
                    },
                    placeholderStyle: TextStyle(color: LColors.white19, fontSize: 14),
                  ),
                  TextInputComponent(
                    controller: reNPasswordController,
                    placeholder: "Repeti tu nueva contraseña",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: true,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Faltó poner tu nueva contraseña!";
                     if (mail != nPasswordController.text)
                        return "Las contraseñas no coinciden";
                      return null;
                    },
                    placeholderStyle: TextStyle(color: LColors.white19, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonComponent(
                  height: 60,
                  onTap: () async{
                    if(formKey.currentState.validate()){
                      OverlayUtils.showLoading(context);
                      String result = await FirebaseUtils.changePassword(password: passwordController.text, newPassword: reNPasswordController.text);
                      Navigator.pop(context);
                      if(result.isEmpty){
                        FirebaseUtils.logout();
                        Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordChanged()));
                      }else{
                        OverlayUtils.showAlert(context, description: result, dismissible: true);
                      }
                    }//password_success
                  },
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 1.8,
                  text: Text("Cambiar la contraseña", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ],
        ),
      ),
   );
  }
}