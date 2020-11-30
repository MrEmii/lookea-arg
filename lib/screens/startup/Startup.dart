import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/Waves.dart';
import 'package:lookea/widgets/button.dart';

class StartupScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: LColors.black9,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: (){
          return Future.value(false);
        },
        child: ListView(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: new Size(MediaQuery.of(context).size.width, 200),
                  painter: WaveTop(),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/logo/Color=White.png"), width: 62,),
                      Text("Lookeá", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("¿Ya tenés una cuenta?", style: TextStyle(color: LColors.black9, fontWeight: FontWeight.w600, fontSize: 18),),
                ),
                ButtonComponent(
                  onTap: () {
                    Navigator.pushNamed(context, "/signIn");
                  },
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 1.8,
                  text: Text("Inicia sesión", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("O mejor", style: TextStyle(color: LColors.black9, fontWeight: FontWeight.w600, fontSize: 18),),
                ),
                ButtonComponent(
                  onTap: () {
                    Navigator.pushNamed(context, "/signUp");
                  },
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 1.8,
                  text: Text("Creá una cuenta", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            )
          ],
        ),
      ),
   );
  }
}
