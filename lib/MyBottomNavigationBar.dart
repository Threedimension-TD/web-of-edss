import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MyBottomBavigationBar extends StatelessWidget {

  const MyBottomBavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,//.withOpacity(1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          
        ),
      ),
      child: Stack(
        children: [
          Center(
          child: Image.asset("assets/images/logo.png"),
          ),
          Padding(padding: EdgeInsets.only(left: 43,top: 10),
          child: SelectableText("开发人员",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          ),

          Padding(padding: EdgeInsets.only(left: 30,top: 25),
          child: ListTile(
            
            leading: CircleAvatar(
            radius: 20, 
            backgroundImage: AssetImage("assets/images/Author.png"),
            
            ),
          title: SelectableText("作者：Threedimension",style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),
          subtitle: SelectableText("联系我们：535061705@qq.com",style: TextStyle(color: const Color.fromARGB(255, 100, 100, 100)),),
          )
          ),
          

          Padding(padding: EdgeInsets.only(left: 30,top: 95),
          child: ListTile(
            
            leading: CircleAvatar(
            radius: 20, 
            backgroundImage: AssetImage("assets/images/Tr1c.png"),
            
            ),
          title: SelectableText("主要设计：Trappist-1c",style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),
          subtitle: SelectableText("一只可爱的小1c",style: TextStyle(color: const Color.fromARGB(255, 100, 100, 100)),),
          )
          ),

          Padding(padding: EdgeInsets.only(left: 30,top: 165),
          child: ListTile(
            
            leading: CircleAvatar(
            radius: 20, 
            backgroundImage: AssetImage("assets/images/luoyuchou.png"),
            
            ),
          title: SelectableText("素材提供：洛雨稠Netflight",style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),
          subtitle: SelectableText("一只可爱的小Nefo",style: TextStyle(color: const Color.fromARGB(255, 100, 100, 100)),),
          )
          ),
          Positioned(
            top: 50,
            left: 1200,
            child: Text('''加入服务器：QQ群742834377
            
永昼生存服务器随时欢迎您的到来！
            ''',style: TextStyle(color: Colors.white,fontSize: 16),))
        ],
      ),
    );
    
  }
}