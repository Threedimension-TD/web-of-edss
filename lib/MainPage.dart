import 'package:flutter/material.dart';
import 'package:web_of_edss/componets/Widget.dart';
import 'package:web_of_edss/componets/WikiCard.dart';
import 'package:web_of_edss/normalpage/PageTemplate.dart';

class MainPage extends StatelessWidget{
  const MainPage({super.key,required this.pageId});
  final String pageId;
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      bodyContent: WikiCard(
 pageId: pageId,
      )
    );
  }
}