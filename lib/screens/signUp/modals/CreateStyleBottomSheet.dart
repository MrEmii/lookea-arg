import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookea/models/hairdresser_model.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/utils/firebase_utils.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/button.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';


class CreateStylePage extends StatefulWidget {
  @override
  _CreateStylePageState createState() => _CreateStylePageState();
}

class _CreateStylePageState extends State<CreateStylePage> {

  TextEditingController _styleName = TextEditingController();
  TextEditingController _stylePrice = TextEditingController();
  TextEditingController _styleDesc = TextEditingController();
  var focusNode = new FocusNode();
  FileImage _image;
  String imageMessage = "Busca una imagen\nque represente el corte";

  Future getImage() async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);
    if (img != null) {
      this.setState(() {
        this._image = FileImage(img);
        this.imageMessage = "";
      });
    }
  }

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SignUpProvider provider = Provider.of<SignUpProvider>(context, listen: true);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Crea un estilo", style: TextStyle(color: LColors.black9, fontSize: 24, fontWeight: FontWeight.w600),),
                Text("Registra un estilo, elegí el precio y subí una foto!", softWrap: true, style: TextStyle(color: LColors.black9, fontSize: 14,),)
              ],
            ),
            GestureDetector(
              onTap: () => this.getImage(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: LColors.black9,
                  borderRadius: BorderRadius.circular(15),
                  image: _image != null ? DecorationImage( image: _image, alignment: Alignment.center, fit: BoxFit.cover) : null
                ),
                child: Center(child: Text(this.imageMessage, textAlign: TextAlign.center,),),
              ),
            ),
            Form(
              key: provider.styleInformationKey,
              child: Column(
                children: [
                  TextInputComponent(
                    controller: this._styleName,
                    placeholder: "Nombre del estilo",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: false,
                    margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Necesitamos un nombre!";
                      return null;
                    },
                  ),
                  TextInputComponent(
                    controller: this._stylePrice,
                    placeholder: "Valor del estilo",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: false,
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    type: TextInputType.number,
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Elige un precio para tu estilo.";
                      return null;
                    },
                  ),
                  TextInputComponent(
                    node: this.focusNode,
                    controller: this._styleDesc,
                    placeholder: "Descripción corta del estilo",
                    width: MediaQuery.of(context).size.width,
                    passwordEnabled: false,
                    multiLine: true,
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    validator: (mail) {
                      if(mail == null || mail.trim().isEmpty)
                        return "Escribe una descripción breve";
                      if(mail.length < 10)
                        return "Útiliza más cáracteres!";
                      return null;
                    },
                  ),
                  ButtonComponent(
                    onTap: () async {
                      if(_image == null) {
                        this.setState(() {
                          this.imageMessage = "Necesitamos una imagen!";
                        });
                      }
                      if(provider.styleInformationKey.currentState.validate() && _image != null){

                        provider.styleImages.putIfAbsent(_styleName.text, () => _image);

                        provider.hairDressModels.add(HairDresseModel(
                          name: _styleName.text,
                          description: _styleDesc.text,
                          price: int.parse(_stylePrice.text),
                          style: provider.shopTypes[provider.currentPreference]
                        ));
                        provider.notify();
                        Navigator.pop(context);
                      }
                    },
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width / 1.8,
                    text: Text("Crear", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}