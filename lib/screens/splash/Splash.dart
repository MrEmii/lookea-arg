import 'package:flutter/material.dart';
import 'package:lookea/providers/NotificationsProvider.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SignInProvider provider = Provider.of(context, listen: false);
    PushNotificationProvider push = Provider.of<PushNotificationProvider>(context, listen: false);

    provider.authenticate().then( (logged) async {
      if(logged){
        Navigator.pushNamed(context, "/");
        push.initNotifications();
      }else{
        Navigator.pushNamed(context, "/startup");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: LColors.black9,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/logo/Color=White.png"), width: 130,),
            Text("Lookeá", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}