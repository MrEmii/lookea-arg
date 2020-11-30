import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/local_data/models/user_model.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/screens/account/modals/PasswordModal.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/dual_widget.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';


class AccountOptionsScreen extends StatefulWidget {

  @override
  _AccountOptionsScreenState createState() => _AccountOptionsScreenState();
}

class _AccountOptionsScreenState extends State<AccountOptionsScreen> {
  @override
  Widget build(BuildContext context) {

    SignUpProvider signUpProvider = Provider.of<SignUpProvider>(context, listen: true);
    UserModel model = LocalData.user;

    return Scaffold(
      appBar: AppHeader(
        title: "Edita tu cuenta",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Form(
            key: signUpProvider.accountInformationKey,
            child: Column(
              children: [
                TextInputComponent(
                  controller: signUpProvider.nameController,
                  placeholder: model.name,
                  width: MediaQuery.of(context).size.width,
                  passwordEnabled: false,
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-ZñÑ]"))
                  ],
                  validator: (mail) {
                    if(mail == null || mail.trim().isEmpty)
                      return "Necesitamos tu nombre!";
                    if (mail.trim().length < 3)
                      return "Tu nombre no puede ser tan corto!";
                    return null;
                  },
                ),
                TextInputComponent(
                  controller: signUpProvider.lastnameController,
                  placeholder: model.lastname,
                  width: MediaQuery.of(context).size.width,
                  passwordEnabled: false,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-ZñÑ]"))
                  ],
                  validator: (mail) {
                    if(mail == null || mail.trim().isEmpty)
                      return "Necesitamos tu apellido!";
                    if (mail.trim().length < 3)
                      return "Tu apellido no puede ser tan corto!";
                    return null;
                  },
                ),
                TextInputComponent(
                  controller: signUpProvider.emailController,
                  placeholder: FirebaseUtils.auth.currentUser.email,
                  type: TextInputType.emailAddress,
                  width: MediaQuery.of(context).size.width,
                  passwordEnabled: false,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny("[ ]")
                  ],
                  validator: (mail) {
                    if(mail == null || mail.trim().isEmpty)
                      return "Necesitamos tu correo!";
                    if(!isEmail(mail))
                      return "Correo electronico no válido!";
                    return null;
                  },
                ),
                TextInputComponent(
                  controller: signUpProvider.cellphoneController,
                  placeholder: model.cellphone,
                  width: MediaQuery.of(context).size.width,
                  passwordEnabled: false,
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  type: TextInputType.phone,
                  validator: (mail) {
                    if(mail == null || mail.trim().isEmpty)
                      return "Necesitamos tu número!";
                    if (mail.trim().length != 10)
                      return "Verifica tu número";
                    return null;
                  },
                  placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Preferencia", textAlign: TextAlign.center, style: TextStyle(color: LColors.gray3, fontSize: 12),),
                      CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 43,
                        useMagnifier: true,
                        squeeze: 1.5,
                        scrollController: new FixedExtentScrollController(initialItem: signUpProvider.shopTypes.indexOf(model.shopType)),
                        onSelectedItemChanged: (i) {
                          signUpProvider.currentPreference = i;
                        },
                        looping: false,
                        children: signUpProvider.shopTypes.map<Widget>((mode) => Center(child: Text(mode, style: TextStyle(color: LColors.black9)))).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Deshabilitar cuenta", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),)
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Text("Una vez que deshabilitis tu cuenta, tenes 30 días antes que se eliminen todos tus datos."),
                ),
                ButtonComponent(
                  background: LColors.gray3,
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 2  ,
                  text: Text("Deshabilitar Cuenta", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          )
        ]
      ),
      floatingActionButton: Builder (
        builder: (context) {
          return  FloatingActionButton.extended(
            onPressed: () async {
              String password = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  contentTextStyle: TextStyle(color: LColors.black9),
                  content: PasswordPage()
                )
              );
              if(password != null && password.isNotEmpty){
                String auth = await FirebaseUtils.reAuth(email: FirebaseUtils.auth.currentUser.email, password: password);
                print("========== RE AUTH ============");
                if(auth == ""){
                  UserModel newModel = model.copyWith(
                    name: signUpProvider.nameController.text.isEmpty? signUpProvider.nameController.text : model.name,
                    lastname: signUpProvider.lastnameController.text.isEmpty? signUpProvider.lastnameController.text : model.name,
                    cellphone: signUpProvider.cellphoneController.text.isEmpty? signUpProvider.cellphoneController.text : model.name,
                    city: signUpProvider.cityController.text.isEmpty? signUpProvider.cityController.text : model.name,
                    county: signUpProvider.countyController.text.isEmpty? signUpProvider.countyController.text : model.name,
                    street: signUpProvider.streetController.text.isEmpty? signUpProvider.streetController.text : model.name,
                    streetNumber: signUpProvider.streetNumberController.text.isEmpty? signUpProvider.streetNumberController.text : model.name,
                    shopType: signUpProvider.shopTypes[signUpProvider.currentPreference],
                  );

                  await FirebaseUtils.updateAccount(model: newModel, add: {"email": signUpProvider.emailController.text?? null});
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Actualizado"),));
                  signUpProvider.reset();
                  signUpProvider.notify();
                  return;
                }

                Scaffold.of(context).showSnackBar(SnackBar(content: Text(auth),));
              }
            },
            icon: Icon(LIcons.save),
            label: Text("Guardar"),
          );
        }
      ),
   );
  }

  bool isEmail(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}