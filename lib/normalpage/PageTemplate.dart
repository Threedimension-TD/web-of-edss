import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';

class PageTemplate extends StatelessWidget {
  final Widget bodyContent; 
  final String backgroundImage; 
  final double cardWidth; 
  final TextEditingController _controller = TextEditingController();

  
  PageTemplate({
    Key? key,
    required this.bodyContent,
    this.backgroundImage = "assets/images/background.png", 
    this.cardWidth = 2000, 
  }) : super(key: key);


void _createNewPage(BuildContext context) {
    String pageId = _controller.text.trim(); 
    if (pageId.isNotEmpty) {
      Navigator.pushNamed(context, '/page/$pageId');  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              backgroundImage
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            ListView(
              physics: ClampingScrollPhysics(),
              cacheExtent: 500.0,
              children: [
                Column(
                  children: [
                    
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(100), 
                        child: Container(
                          
                          width: cardWidth, 
                          child: bodyContent
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: MyBottomBavigationBar(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
