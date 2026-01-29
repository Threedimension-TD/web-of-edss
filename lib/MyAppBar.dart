import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web_of_edss/MenuItem.dart';
import 'package:web_of_edss/services/auth_service.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}


class _MyAppBarState extends State<MyAppBar> {

  Map<String, dynamic>? _userInfo;
bool _loading = true;

@override
void initState() {
  super.initState();
  _loadUser();
}

Future<void> _loadUser() async {
  final user = await AuthService.getLocalUserInfo();
  setState(() {
    _userInfo = user;
    _loading = false;
  });
}

  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(padding: EdgeInsets.only(left: 20),
      child: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,color: Colors.white,)),),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        
        toolbarHeight: 80.0,
        
        actions: 
           [
            
              
            IconButton(onPressed: () {
            Navigator.pushNamed(context, '/home');
           }, icon: Image.asset("assets/images/logo.png"),
           iconSize: 60.0,
           padding: EdgeInsets.only(left: 100.0),
           ),

            
           

           Padding(
            padding: EdgeInsets.only(right: 960),
            child:Tooltip(
              message: "跳转首页",
              child: TextButton(onPressed: () {
           Navigator.pushNamed(context, '/home');
           }, child: Text("永昼生存服务器",style: TextStyle(color: Colors.white,fontSize: 30.0),)),
            )
            
           ),

           


           

          /* if (!_loading)
          Padding(
          padding: EdgeInsets.only(right: 20),
          child: _userInfo == null
           ? _buildLoginButton(context)
            : _buildAvatar(),
           ),*/


           Padding(padding: EdgeInsets.only(right: 10),
           child:Tooltip(
            message: "更新日志",
            child: IconButton(onPressed: () {
            Navigator.pushNamed(context, '/update');
           }, icon: Icon(Icons.update,color: Colors.white,size: 28,)
           ),
           )
           
           ),

           Tooltip(
            message: "更多页面",
            child: _buildMenuButton(context),
           ),
           
           
         
           
            
         ],
        
    );
  }

  Widget _buildMenuButton(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 30),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<MenuItem>(
          
          customButton: Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
            ),

            items: 
            
            MenuItems.items
            .map((item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ))
            .toList(),
            onChanged: (item) {
              if(item != null) Navigator.pushNamed(context, item.route);
            },

            dropdownStyleData: DropdownStyleData(
              width: 200,
              maxHeight: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromARGB(73, 0, 0, 0).withOpacity(0.8),
              ),
              offset: Offset(0, 5)
            ),
        )
      ),
    );
  }



  Widget _buildLoginButton(BuildContext context) {
  return Tooltip(
    message: "登录",
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.only(right: 10),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Text(
        "登录",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    ),
  );
}



Widget _buildAvatar() {
  return Tooltip(
    message: "已登录",
    child: CircleAvatar(
      radius: 18,
      backgroundImage:
          AssetImage('assets/images/Tr1c.png'),
      backgroundColor: Colors.grey[300],
    ),
  );
}
}
