import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

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
                          height: 300,//记得根据不同的文本长度进行调整
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //放置文本(普通文本统一Padding:left30，标题Padding:all30)
                              Padding(padding: EdgeInsets.all(30),
                              child: SelectableText("更新日志",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize:40,fontWeight: FontWeight.normal),),
                              ),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              Padding(padding: EdgeInsets.only(left: 30),
                              child: SelectableText("v26.1.26",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 30,fontWeight: FontWeight.w100),),),
                              Padding(padding: EdgeInsets.only(left: 30),
                              child: SelectableText("解决了一些提出问题的甲方",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w200),),
                              )
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