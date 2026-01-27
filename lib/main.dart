import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:web_of_edss/normalpage/NotFoundPage.dart';
import 'package:web_of_edss/normalpage/UpdatePage.dart';
import 'MainPage.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      debugShowMaterialGrid: false, 
      showPerformanceOverlay: false, 
      title: "永昼生存服务器|Eternal Dawn Survival Server",
      theme: ThemeData(
        fontFamily: null,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 52, 194, 255),
          primary: Color(0xFF4A90E2),
          )
      ),
      initialRoute: '/home',
      routes: {
        '/home':(context) => const MainPage(),
        '/update':(context) => const UpdatePage(),
      },

      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
      },
      );
  }
}