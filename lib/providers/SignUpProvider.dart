import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lookea/models/hairdresser_model.dart';
import 'package:lookea/models/payment_model.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:intl/intl.dart';


class SignUpProvider extends ChangeNotifier{

  final GlobalKey<FormState>  basicInformationKey = GlobalKey<FormState>();
  final GlobalKey<FormState>  shopInformationKey = GlobalKey<FormState>();
  final GlobalKey<FormState>  styleInformationKey = GlobalKey<FormState>();
  final GlobalKey<FormState>  accountInformationKey = GlobalKey<FormState>();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  List<String>          shopTypes = ["Barberia", "Peluqueria", "Estilista"];
  TextEditingController countyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  List<HairDresseModel> hairDressModels = [];
  List<String>          availablesDays = [];
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController atTimeController = TextEditingController();
  List<String>          images = [];
  List<File>            imagesFile = [];
  Map<String, FileImage> styleImages = {};

  int  currentPreference = 0;
  bool isClient = true;

  DateTime fromDateTime;
  DateTime atDateTime;

  Future<String> register() async{
    try {
      var userPosition = await Geolocator.getLastKnownPosition();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );

      userCredential.user.sendEmailVerification();

      String path = userCredential.user.uid;

      await FirebaseFirestore.instance.collection("users").doc(path).set({
        "id": path,
        "name": nameController.text,
        "lastname": lastnameController.text,
        "mail": emailController.text,
        "cellphone": cellphoneController.text,
        "preference": shopTypes[currentPreference],
        "client": isClient,
        "photo": "none",
        "payments": [
          PaymentModel(PaymentType.EFECTIVO, "", 0, "").toJson()
        ],
      });

      if(!isClient){
        for (var entry in styleImages.entries) {
          String urlImage = await FirebaseUtils.uploadFile(path: "$path/${entry.key}", image: entry.value.file);
          this.hairDressModels.firstWhere((element) => element.name == entry.key).image = urlImage;
        }

        for (File f in imagesFile) {
          String urlImage = await FirebaseUtils.uploadFile(path: "$path", image: f);
          this.images.add(urlImage);
        }
        var ulong = userPosition.longitude;
        var ulat = userPosition.latitude;
        await FirebaseFirestore.instance.collection("locals").doc(userCredential.user.uid).set({
          "alias": shopNameController.text,
          "at": DateFormat("HH:mm").format(atDateTime),
          "available": availablesDays,
          "from": DateFormat("HH:mm").format(fromDateTime),
          "hairdress": hairDressModels.map((e) => e.toJson()).toList(),
          "images": images,
          "lat": ulat,
          "long": ulong
        });
      }

      return "";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'La contraseña es muy corta';
      } else if (e.code == 'email-already-in-use') {
        return 'El correo ya está registrado.';
      } else if(e.code == "wrong-password"){
        return "Contrasela incorrecta";
      }
    } catch (e) {
      print("========= ERROR =========");
      print(e);
    }
    return "Server error";
  }

  void reset(){
    confirmPasswordController = TextEditingController();
    streetNumberController = TextEditingController();
    cellphoneController = TextEditingController();
    lastnameController = TextEditingController();
    passwordController = TextEditingController();
    streetController = TextEditingController();
    countyController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    cityController = TextEditingController();
    shopNameController = TextEditingController();
    hairDressModels.clear();
    availablesDays.clear();
    fromTimeController = TextEditingController();
    atTimeController = TextEditingController();
    images.clear();
    imagesFile.clear();
    styleImages.clear();
    currentPreference = 0;
    isClient = true;
    fromDateTime = null;
    atDateTime = null;
  }

  void notify(){
      notifyListeners();
  }

}

/*



 */