import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';

class NormalPageTemplate extends StatelessWidget {
  const NormalPageTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
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
                      child: Padding(padding: EdgeInsets.all(100),
                      child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                        child: SizedBox(
                          width: 2000,
                          height: 400,//记得根据不同的文本长度进行调整
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //放置文本
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                    Container(
                    margin: EdgeInsets.only(top: 50), 
                    child: MyBottomBavigationBar(),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
    
  }
  
}

