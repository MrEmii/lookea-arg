import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/screens/signUp/modals/CreateStyleBottomSheet.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/date_input.dart';
import 'package:lookea/widgets/dual_widget.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

class CreateShopScreen extends StatefulWidget {

  @override
  _CreateShopScreenState createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {


  Future getImage(SignUpProvider provider) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);
    if (img != null) {
      provider.imagesFile.add(img);
      provider.notify();
    }
  }

  @override
  Widget build(BuildContext context) {

    SignUpProvider provider = Provider.of<SignUpProvider>(context, listen: true);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Registrá tu local", style: TextStyle(color: LColors.black9, fontSize: 24, fontWeight: FontWeight.w600),),
                Text("Ahora que creaste tu cuenta, tenemos que conocer tu local.", softWrap: true, style: TextStyle(color: LColors.black9, fontSize: 14,),)
              ],
            ),
            Form(
              key: provider.shopInformationKey,
              child: Column(
                children: [
                  TextInputComponent(
                    controller: provider.shopNameController,
                    placeholder: "Nombre del local",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: false,
                    margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                    type: TextInputType.phone,
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Necesitamos el nombre de tu local!";
                      return null;
                    },
                    placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
                  ),
                  TextInputComponent(
                    controller: provider.cellphoneController,
                    placeholder: "Número de télefono",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: false,
                    margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
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
                        Text("¿De qué es tu local?", textAlign: TextAlign.center, style: TextStyle(color: LColors.gray3, fontSize: 12),),
                        CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 43,
                          useMagnifier: true,
                          squeeze: 1.5,
                          scrollController: new FixedExtentScrollController(initialItem: provider.currentPreference),
                          onSelectedItemChanged: (i) {
                            provider.currentPreference = i;
                          },
                          looping: false,
                          children: provider.shopTypes.map<Widget>((mode) => Center(child: Text(mode, style: TextStyle(color: LColors.black9)))).toList(),
                        ),
                      ],
                    ),
                  ),
                  DualWidget(
                    left: TextInputComponent(
                      controller: provider.streetController,
                      width: MediaQuery.of(context).size.width / 2,
                      placeholder: "Calle",
                      passwordEnabled: false,
                      margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 5),
                      type: TextInputType.streetAddress,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos tu dirección!";
                        return null;
                      },
                    ),
                    right: TextInputComponent(
                      width: MediaQuery.of(context).size.width / 2,
                      controller: provider.streetNumberController,
                      placeholder: "CP",
                      passwordEnabled: false,
                      margin: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 20),
                      type: TextInputType.number,
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos saber tu código postal!";
                        return null;
                      },
                    )
                  ),
                  DualWidget(
                    left: TextInputComponent(
                      controller: provider.countyController,
                      width: MediaQuery.of(context).size.width / 2,
                      placeholder: "Provincia",
                      passwordEnabled: false,
                      margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 5),
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos saber tu pronvicia!";
                        return null;
                      },
                    ),
                    right: TextInputComponent(
                      width: MediaQuery.of(context).size.width / 2,
                      controller: provider.cityController,
                      placeholder: "Ciudad",
                      passwordEnabled: false,
                      margin: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 20),
                      validator: (mail) {
                        if(mail == null || mail.trim().isEmpty)
                          return "Necesitamos saber tu ciudad!";
                        return null;
                      },
                    )
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Disponibilidad", textAlign: TextAlign.center, style: TextStyle(color: LColors.gray3, fontSize: 12),),
                        TextInputComponent(
                          controller: provider.countyController,
                          width: MediaQuery.of(context).size.width,
                          placeholder: "Dias de la semana",
                          passwordEnabled: false,
                          margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                          validator: (mail) {
                            if(mail == null || mail.trim().isEmpty)
                              return "Necesitamos saber tu pronvicia!";
                            return null;
                          },
                        ),
                        DualWidget(
                          left: DateInput(
                            margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 5),
                            width: MediaQuery.of(context).size.width / 2,
                            placeholder: "Desde las:",
                            controller: provider.fromTimeController,
                            onShowPicker: (ctx, DateTime value) async {
                              TimeOfDay time = await pickTime(ctx);
                              if (time != null && ctx != null) {
                                provider.fromTimeController.text = format(Duration(hours: time.hour, minutes: time.minute));
                                provider.fromDateTime = DateFormat("HH:mm:ss").parse(provider.fromTimeController.text);
                              }
                            },
                            validator: (v) {
                              return null;
                            },
                          ),
                          right: DateInput(
                            margin: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 20),
                            width: MediaQuery.of(context).size.width / 2,
                            placeholder: "Hasta las:",
                            controller: provider.atTimeController,
                            onShowPicker: (ctx, value) async {
                              TimeOfDay time = await pickTime(ctx);
                              if (time != null && ctx != null) {
                                provider.atTimeController.text = format(Duration(hours: time.hour, minutes: time.minute));
                                provider.atDateTime =  DateFormat("HH:mm:ss").parse(provider.atTimeController.text);
                              }
                            },
                            validator: (v) {
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Text("Subi imagenes de tu local", style: TextStyle(color: LColors.gray3, fontSize: 12),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 10, bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => this.getImage(provider),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(color: LColors.black9, borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Icon(LIcons.image_plus, color: Colors.white))
                          ),
                        ),
                        ...provider.imagesFile.map((img) => Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: LColors.black9,
                            borderRadius: BorderRadius.circular(15),
                            image: img != null ? DecorationImage( image: FileImage(img), alignment: Alignment.center, fit: BoxFit.cover) : null
                          ),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    provider.imagesFile.remove(img);
                                    provider.notify();
                                  },
                                  child: Icon(LIcons.image_times, color: LColors.red37, size: 32),
                                )
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  Text("Subi cortes de pelo", style: TextStyle(color: LColors.gray3, fontSize: 12),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (_) => CreateStylePage()
                            );
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(color: LColors.black9, borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Icon(LIcons.file_landscape_alt, color: Colors.white))
                          ),
                        ),
                        ...provider.hairDressModels.map((hair) => Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: LColors.black9,
                            borderRadius: BorderRadius.circular(15),
                            image: hair != null ? DecorationImage( image: provider.styleImages[hair.name], alignment: Alignment.center, fit: BoxFit.cover) : null
                          ),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    provider.hairDressModels.remove(hair);
                                    provider.styleImages.remove(hair.name);
                                    provider.notify();
                                  },
                                  child: Icon(LIcons.times_circle, color: Colors.red.withOpacity(0.57), size: 32),
                                )
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  ButtonComponent(
                    onTap: () async {
                      if(provider.shopInformationKey.currentState.validate()
                        && provider.imagesFile.length != 0
                        && provider.hairDressModels.length != 0
                        && provider.styleImages.length != 0) {
                          OverlayUtils.showLoading(context);

                          String result = await provider.register();
                          if(result.trim().isEmpty){
                            Navigator.pushNamed(context, "/register/success");
                          }else{
                            Navigator.pop(context);
                            OverlayUtils.showAlert(context, description: result);
                          }
                      }else{
                        OverlayUtils.showAlert(context, description: "Faltaron cosas por rellenar.");
                      }
                    },
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width / 1.8,
                    text: Text("Registrarse", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )
          ],
        ),
      )
   );
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  Future<TimeOfDay> pickTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }
}
