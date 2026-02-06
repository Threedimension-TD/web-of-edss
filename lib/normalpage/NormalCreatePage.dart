import 'package:flutter/material.dart';
import 'package:web_of_edss/normalpage/PageTemplate.dart';
import 'package:web_of_edss/specialpage/CreatePage.dart';

class NormalCreatePage extends StatelessWidget{
   NormalCreatePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      bodyContent: SizedBox(
        child:CreatePage()
      )
    );
  }
}