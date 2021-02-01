import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/screens/start/widgets/SliverPersistent.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/Waves.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/utils/overlay_utils.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:lookea/widgets/dual_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {


  List<Widget> clientInformation(SignUpProvider provider){
    return <Widget>[
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
            Text("¿Cuál es tu preferencia?", textAlign: TextAlign.center, style: TextStyle(color: LColors.gray3, fontSize: 12),),
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
    ];
  }

  List<Widget> localInformation(SignUpProvider provider){
    return <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text("Una vez completes todo, vamos a necesitar saber un poco más de tu local", textAlign: TextAlign.center, style: TextStyle(color: LColors.gray3, fontSize: 11),),
      ),
      TextInputComponent(
        controller: provider.shopNameController,
        placeholder: "Nombre del local",
        width: MediaQuery.of(context).size.width,
        passwordEnabled: false,
        margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
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
      Center(
        child: GestureDetector(
          onTap: () async {
            OverlayUtils.showLoading(context);
            LocationPermission perms = await Geolocator.checkPermission();
            if(perms != LocationPermission.always || perms != LocationPermission.whileInUse) perms = await Geolocator.requestPermission();
            if(perms == LocationPermission.always || perms == LocationPermission.whileInUse){
              var userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
              final coordinates = new Coordinates(userPosition.latitude, userPosition.longitude);
              var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
              var first = addresses.first;
              Navigator.pop(context);
              if(first != null){
                List<String> ubication = first.addressLine.split(",").sublist(1);
                String street = ubication[0].split('').map((e) => e.isNotEmpty ? num.tryParse(e) == null ? e  : "" : "").toList().join("").trim();
                String streetNumber = ubication[0].split('').map((e) => e.isNotEmpty ? num.tryParse(e) ?? "" : "").toList().join("").trim();
                String city = ubication[1].split(" ").sublist(2).join(" ").trim();
                String county = ubication[2].trim();
                print("$street $streetNumber - $city - $county");
                provider.streetController.text = street;
                provider.streetNumberController.text = streetNumber;
                provider.cityController.text = city;
                provider.countyController.text = county;
                return;
              }
            }

            OverlayUtils.showAlert(context, description: "No pudimos acceder a tu ubicación", dismissible: true);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: LColors.gray6,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Text("Busca mi ubicación", style: TextStyle(color: LColors.gray50)),
          ),
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
          placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
        ),
        right: TextInputComponent(
          width: MediaQuery.of(context).size.width / 2,
          controller: provider.streetNumberController,
          placeholder: "Número",
          passwordEnabled: false,
          margin: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 20),
          type: TextInputType.number,
          validator: (mail) {
            if(mail == null || mail.trim().isEmpty)
              return "Necesitamos saber tu código postal!";
            return null;
          },
          placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
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
          placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
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
          placeholderStyle: TextStyle(color: LColors.white19, fontSize: 18),
        )
      ),
    ];
  }


  bool isEmail(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignUpProvider provider = Provider.of<SignUpProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: LColors.black9,
          toolbarHeight: 0,
          leading: Container(),
        ),
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            provider.reset();
            return Future.value(true);
          },
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              print(innerBoxIsScrolled);
              return [
                SliverPersistentHeader(
                  pinned: false,
                  floating: true,
                  delegate: PersistentHeaderDelegate(
                    maxExtents: 130,
                    minExtends: 40,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: new Size(MediaQuery.of(context).size.width, 130),
                          painter: WaveNormal(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Registrate", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600),)
                        )
                      ],
                    )
                  )
                )
              ];
            },
            body: ListView(
              children: [
                Form(
                  key: provider.basicInformationKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextInputComponent(
                          controller: provider.nameController,
                          placeholder: "Nombre",
                          width: MediaQuery.of(context).size.width,
                          passwordEnabled: false,
                          margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
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
                          controller: provider.lastnameController,
                          placeholder: "Apellido",
                          width: MediaQuery.of(context).size.width,
                          passwordEnabled: false,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          controller: provider.emailController,
                          placeholder: "Correo",
                          type: TextInputType.emailAddress,
                          width: MediaQuery.of(context).size.width,
                          passwordEnabled: false,
                          capitalization: TextCapitalization.none,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          controller: provider.passwordController,
                          placeholder: "Contraseña",
                          width: MediaQuery.of(context).size.width,
                          passwordEnabled: true,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          validator: (mail) {
                            if(mail != provider.confirmPasswordController.text)
                              return "Las contraseñas no coinciden";
                            if(mail == null || mail.trim().isEmpty)
                              return "Necesitamos tu contraseña!";
                            if (mail.trim().length < 8)
                              return "Usa 8 caracteres como minimo";
                            if (!mail.contains(RegExp(r'\d'), 0))
                              return "Usa al menos un número";
                            if (!mail.contains(new RegExp(r'[A-Z]'), 0))
                              return "Usa al menos una mayúscula";
                            return null;
                          },
                        ),
                        TextInputComponent(
                          controller: provider.confirmPasswordController,
                          placeholder: "Confirma la contraseña",
                          width: MediaQuery.of(context).size.width,
                          passwordEnabled: true,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          validator: (mail) {
                            if(mail != provider.passwordController.text)
                              return "Las contraseñas no coinciden";
                            if(mail == null || mail.trim().isEmpty)
                              return "Necesitamos tu contraseña!";
                            if (mail.trim().length < 8)
                              return "Usa 8 caracteres como minimo";
                            if (!mail.contains(RegExp(r'\d'), 0))
                              return "Usa al menos un número";
                            if (!mail.contains(new RegExp(r'[A-Z]'), 0))
                              return "Usa al menos una mayúscula";
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.isClient = true;
                                  provider.notify();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text("Soy un cliente", style: provider.isClient ?  TextStyle(fontSize: 18, color: LColors.black9) :  TextStyle(fontSize: 14, color: LColors.white26)),
                                )
                              ),
                              GestureDetector(
                                  onTap: () {
                                  provider.isClient = false;
                                  provider.notify();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text("Tengo un local", style: !provider.isClient ?  TextStyle(fontSize: 18, color: LColors.black9) :  TextStyle(fontSize: 14, color: LColors.white26)),
                                )
                              ),
                            ],
                          ),
                        ),
                        if(provider.isClient)
                          ...[
                            ...clientInformation(provider),
                          ]
                        else
                          ...localInformation(provider),
                        ButtonComponent(
                          onTap: () async{
                            if(provider.basicInformationKey.currentState.validate()){
                              if(provider.isClient){
                                OverlayUtils.showLoading(context);
                                String result = await provider.register();
                                Navigator.pop(context);
                                if(result.trim().isEmpty){
                                  Navigator.pushNamedAndRemoveUntil(context, "/register/success", (Route<dynamic> route) => false);
                                }else{
                                  OverlayUtils.showAlert(context, description: result);
                                }
                              }else{
                                Navigator.pushNamed(context, "/register/shop");
                              }
                            }
                          },
                          margin: EdgeInsets.all(40),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          width: MediaQuery.of(context).size.width / 1.8,
                          text: Text(provider.isClient ? "Registrarse" : "Continuar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ButtonComponent(
                            onTap: () {
                              launch("https://www.youtube.com/watch?v=uZiGkQTHUBU");
                            },
                            margin: EdgeInsets.all(40),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Text("Ver términos y condiciones", style: TextStyle(color: LColors.gray50, fontWeight: FontWeight.w600)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
       ),
    );
  }
}