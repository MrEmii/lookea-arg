import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:lookea/providers/CardProvider.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/providers/NotificationsProvider.dart';
import 'package:lookea/providers/ShopProvider.dart';
import 'package:lookea/providers/SignInProvider.dart';
import 'package:lookea/providers/SignUpProvider.dart';
import 'package:lookea/screens/account/Account.dart';
import 'package:lookea/screens/account/screens/AccountOptions.dart';
import 'package:lookea/screens/account/screens/EditPassword.dart';
import 'package:lookea/screens/account/screens/Payments.dart';
import 'package:lookea/screens/lostpassword/LostPassword.dart';
import 'package:lookea/screens/notifications/Notifications.dart';
import 'package:lookea/screens/shop/ShopScreen.dart';
import 'package:lookea/screens/shop/screens/ReservationScreen.dart';
import 'package:lookea/screens/signIn/SignIn.dart';
import 'package:lookea/screens/signUp/SignUp.dart';
import 'package:lookea/screens/signUp/screens/AccountCreated.dart';
import 'package:lookea/screens/signUp/screens/CreateShop.dart';
import 'package:lookea/screens/splash/Splash.dart';
import 'package:lookea/screens/start/Start.dart';
import 'package:lookea/screens/startup/Startup.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:provider/provider.dart';


class LookeaRouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
        ChangeNotifierProvider<ShopProvider>(create: (_) => ShopProvider()),
        ChangeNotifierProvider<PushNotificationProvider>(create: (_) => PushNotificationProvider()),
        ChangeNotifierProvider<CardProvider>(create: (_) => CardProvider()),
      ],
      child: App(),
    );
  }
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Map<String, Widget> appRoutes = {
    "/splash": SplashScreen(),
    "/startup":StartupScreen(),
    "/signIn": SignInScreen(),
    "/signIn/lostpassword": LostPasswordScreen(),
    "/signUp": SignUpScreen(),
    "/register/shop": CreateShopScreen(),
    "/register/success": AccountCreatedScreen(),
    "/": StartScreen(),
    "/notifications": NotificationsScreen(),
    "/account": AccountScreen(),
    "/account/options": AccountOptionsScreen(),
    "/account/password": PasswordScreen(),
    "/account/payments": PaymentsMethodsScreen(),
    "/shop": ShopScreen(),
    "/shop/reservation": ReservationPage(),
  };

  @override
  Widget build(BuildContext context) {

    FirebaseAnalytics analytics = FirebaseAnalytics();
    FirebaseAnalyticsObserver observer =FirebaseAnalyticsObserver(analytics: analytics);

    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      title: 'Lookeá',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: LColors.black9,
        accentColor: LColors.white26,
        canvasColor: Colors.white,

        fontFamily: "Poppins",

        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          bodyText2: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          button: TextStyle(fontFamily: "Poppins", color: Colors.white),
          headline1: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          headline2: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          headline3: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          headline4: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          subtitle1: TextStyle(fontFamily: "Poppins", color: LColors.black9),
          subtitle2: TextStyle(fontFamily: "Poppins", color: LColors.black9),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: LColors.black9,
          splashColor: LColors.black9,
          focusColor: LColors.black9,
          elevation: 0,
          foregroundColor: Colors.white,
          hoverColor: LColors.black9,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
        ),

        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.white,
          elevation: 0,
          textTheme: TextTheme(
            body1: TextStyle(color: LColors.black9),
            title: TextStyle(color: LColors.black9, fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w600),
          ),
          iconTheme: IconThemeData(
            color: LColors.black9
          )
        )
      ),
      onGenerateRoute: (RouteSettings settings) {
        String path = settings.name;
        Widget widget = appRoutes[path];
        return SlideRightRoute(widget: widget, settings: settings);
      },
      initialRoute: "/splash",
    );
  }

}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  RouteSettings settings;
  SlideRightRoute({this.widget, this.settings}) : super(
    settings: settings,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}