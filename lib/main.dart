import 'dart:io';

import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:web_of_edss/componets/WikiCard.dart';
import 'package:web_of_edss/normalpage/NormalCreatePage.dart';
import 'package:web_of_edss/normalpage/NotFoundPage.dart';
import 'package:web_of_edss/normalpage/PageTemplate.dart';
import 'package:web_of_edss/normalpage/UpdatePage.dart';
import 'package:web_of_edss/specialpage/CreatePage.dart';
import 'package:web_of_edss/specialpage/LoginPage.dart';
import 'package:web_of_edss/specialpage/RegisterPage.dart';
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
      title: "永昼生存服务器 | Eternal Dawn Survival Server",
      theme: ThemeData(
        fontFamily: null,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 52, 194, 255),
          primary: Color(0xFF4A90E2),
          )
      ),
      initialRoute: '/',
  onGenerateRoute: (settings) {
    final name = settings.name ?? '/';
    if (name == '/') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => MainPage(pageId: "主页",),
      );
    }

    // 创建页
    if (name == '/create') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => NormalCreatePage(),
      );
    }

    if(name == '/login') {
      
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => LoginPage()
        );
    }

    if(name == '/register') {
      
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => RegisterPage()
        );
    }


    // Wiki 页面：/wiki/xxx
    if (name.startsWith('/wiki/')) {
      final pageId = name.replaceFirst('/wiki/', '');
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => PageTemplate(
          bodyContent: WikiCard(pageId: pageId),
        ),
      );
    }

    return MaterialPageRoute(
      builder: (_) => NotFoundPage(),

  
    );
      
  });
  }

}