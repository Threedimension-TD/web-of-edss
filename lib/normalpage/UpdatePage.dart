import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';
import 'package:web_of_edss/componets/Widget.dart';

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
                          height: 600,//记得根据不同的文本长度进行调整
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //放置文本(普通文本统一Padding:left30，标题Padding:all30)
                              Padding(padding: EdgeInsets.all(30),
                              child: SelectableText("更新日志",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize:52,fontWeight: FontWeight.normal),),
                              ),
                              Padding(padding: EdgeInsets.only(left: 30),
                              child: SelectableText('''最新更新''',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 36,fontWeight: FontWeight.normal),),),
                              Text(""),
                              Padding(padding: EdgeInsets.only(left: 30),
                              child: SelectableText("v26.2.10",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 30,fontWeight: FontWeight.normal),),),
                              
                              NormalText('''新增了删除页面功能

修复了一些已知问题并且解决了一些捣乱的用户'''),
                              Text(""),
                              Padding(padding: EdgeInsets.only(left: 30),
                              child: SelectableText("历史更新",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 36,fontWeight: FontWeight.w100),),
                              ),
                              Text(""),
                              SubTitleText("v26.2.6"),
                              NormalText("EDSSWiki正式上线（？）")
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