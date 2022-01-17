import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/Translation.dart';
import 'package:colireli_delivery/UI/Dashboard.dart';
import 'package:colireli_delivery/UI/OutToDelivery.dart';
import 'package:colireli_delivery/UI/Shipment_Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/LoginUi.dart';
import 'UI/Profile.dart';
import 'UI/Stats.dart';
import 'UI/Wallet.dart';
import 'UI/home.dart';

String?  token;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = await prefs.getString("token");
  print("tokenn is:$token");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale:Get.deviceLocale,
      fallbackLocale: Locale('en'),

      theme: ThemeData(
          primaryColor: colireli,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme
          )
      ),
      initialRoute:token == null ? "/login" : "/",
      routes: {
        '/': (context) => AnimatedSplashScreen(splash: 'assets/coliReliLogo.png',
          splashTransition: SplashTransition.slideTransition,
          duration: 2000,
          backgroundColor: colireli,
          splashIconSize: 250,





          nextScreen: home(),

        ),
        "/login": (context) => LoginUi(),
      },
     /* getPages: [
        GetPage(name: '/shipmentCard', page:()=> ShipementCard()),
        GetPage(name: '/dashboard', page:()=> Dashboard()),
        GetPage(name: '/ouToDeliver', page:()=> OutToDelivery()),
        GetPage(name: '/profile', page:()=> Profile()),
        GetPage(name: '/Stats', page:()=> Stats()),
        GetPage(name: '/wallet', page:()=> Wallet()),
      ],*/
    );
  }
}




