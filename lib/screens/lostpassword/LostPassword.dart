import 'package:flutter/material.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'package:lookea/widgets/app_header.dart';
import 'package:provider/provider.dart';


class LostPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SignInProvider provider = Provider.of<SignInProvider>(context);

    return Scaffold(
      appBar: AppHeader(
        title: "",
      ),
      body: Column(
        children: [
          Text("¿Olvidate tú contraseña?", style: TextStyle(),)
        ],
      ),
   );
  }
}