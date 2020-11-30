import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/local_data/models/user_model.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'package:lookea/screens/account/widgets/AccountOption.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/cached_image.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  Future<PickedFile> getImage() async {
    return await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);
  }

  @override
  Widget build(BuildContext context) {
    SignInProvider provider = Provider.of<SignInProvider>(context, listen: true);
    MainProvider mprovider = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: LColors.black9,
      appBar: AppBar(
        backgroundColor: LColors.black9,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(LIcons.bell, color: Colors.white,), onPressed: () => Navigator.pop(context))
        ],
        leading: IconButton(icon: Icon(LIcons.angle_left, color: Colors.white,), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: new Text("Tú cuenta", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                CachedImage(
                  url: LocalData.user.photoUrl,
                  width: 100,
                  height: 100,
                  borderRadius: BorderRadius.circular(100),
                  placeholder: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                  errorImg: "assets/images/user/avatar-white.png"
                ),
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: GestureDetector(
                    onTap: () async {
                      OverlayUtils.showLoading(context);
                      PickedFile file =  await getImage();
                      UserModel model = LocalData.user;
                      if(model.photoUrl == null || model.photoUrl.isEmpty || model.photoUrl != "none") await FirebaseUtils.deleteFile(path: "users/${model.id}/${model.id}");
                      String url = await FirebaseUtils.uploadFile(path: "users/${model.id}", id: model.id,  image: File(file.path));
                      await FirebaseUtils.updateAccount(model: model.copyWith(photoUrl: url));
                      Navigator.pop(context);
                      provider.notify();
                      mprovider.notify();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: LColors.black9,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(LIcons.image, size: 18,),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                child: Text("${LocalData.user.name} ${LocalData.user.lastname}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    itemExtent: 100,
                    children: [
                      AccountOption(
                        icon: LIcons.cog,
                        name: "Opciones de cuenta",
                        onTap: () => Navigator.pushNamed(context, "/account/options"),
                      ),
                      AccountOption(
                        icon: LIcons.lock,
                        name: "Editar contraseña",
                        onTap: () => Navigator.pushNamed(context, "/account/password"),
                      ),
                      AccountOption(
                        icon: LIcons.credit_card,
                        name: "Nétodos de pago",
                        onTap: () => Navigator.pushNamed(context, "/account/payments"),
                      ),
                      AccountOption(
                        icon: LIcons.question_circle,
                        name: "Ayuda",
                        onTap: (){
                          print("HOLA");
                        },
                      ),
                      AccountOption(
                        icon: LIcons.exit,
                        name: "Cerrar sesión",
                        color: LColors.red61,
                        onTap: (){
                          FirebaseUtils.logout();
                          Navigator.pushNamedAndRemoveUntil(context, "/startup", (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  )
                ),
              )
            )
          ],
        ),
      ),
   );
  }
}