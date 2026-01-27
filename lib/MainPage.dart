import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';

class MainPage extends StatelessWidget{
  const MainPage({super.key});
  
  @override
  Widget build(BuildContext context) {
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
                height: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(30),
                    child: SelectableText("  首页",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize:40,fontWeight: FontWeight.normal),),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText("永昼生存服务器",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 30,fontWeight: FontWeight.w100),),
                    ),
                    Divider(
                      color: Color.fromARGB(95, 0, 0, 0),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText("一个带有Fabric Create模组的Minecraft服务器",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w200),),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 40,
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText('''欢迎来到永昼生存服务器Wiki！我们是一个为爱发电性质，原版和模组兼容并包的服务器，尽量保证生存的原面貌。

我们是一个为爱发电性质，原版和模组兼容并包的服务器，尽量保证生存的原面貌。

服务器在24年12月14日开服，现在已经有半年的时间了

愿所有在阴雨中的人们，都能在服务器中鼓起面对生活，改变生活的勇气。——服主 Trappist-1c

请各位不要在服务器建造可以引起服务器大型卡顿的建筑（全物品已经在尝试改了，别骂了别骂了）
''',style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w200),),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText("服务器配置",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 30,fontWeight: FontWeight.w100),),
                    ),
                    Divider(
                      color: Color.fromARGB(95, 0, 0, 0),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText('''MC版本：1.20.1

Fabric版本：用最新版便可

模组：见群文件（核心:机械动力 机械动力-汽鸣铁道）
''',style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w200),),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText("描述主题",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 30,fontWeight: FontWeight.w100),),
                    ),
                    Divider(
                      color: Color.fromARGB(95, 0, 0, 0),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30),
                    child: SelectableText('''本Wiki旨在描述服务器的各种设定和区划名称，以此来更好了解服务器。

接下来，这些页面可能帮到你''',style: TextStyle(color: Color.fromARGB(170, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w200),),
                    ),
                    
                  ],
                )
                
              ),
            ),
            
              )
            ),
            SizedBox(height: 0),
           
           Container(
            
              margin: EdgeInsets.only(top: 50), // 与上面内容的间距
              child: MyBottomBavigationBar(),
            ),
          ],
        ),
            ] 
           
      ),
          
          
          
        ],
       ),
       
      ),
      
        
      );
      
  }
}