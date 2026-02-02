import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';
import 'package:web_of_edss/componets/Widget.dart';
import 'package:web_of_edss/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  


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
                      child: SizedBox(
                        height: 400,
                        width: 500,
                        child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                        child: IntrinsicHeight(
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: TitleText("登录"),
                              ),
                              Center(
                                child: SizedBox(
                                width: 300,
                                height: 40,
                                child:TextField(
                                controller: _usernameController, 
                                decoration: InputDecoration(
                                  labelText: '用户名/邮箱',
                                  hintText: '请输入用户名或邮箱',
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true
                                ),
                                
                                onChanged: (value) {
                                 // 实时监听输入变化
                                print('用户名输入: $value');
                                },
                              )
                              ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 300,
                                  height: 40,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true, // 隐藏密码
                                    decoration: InputDecoration(
                                    labelText: '密码',
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                                    
                                    ),
                                    fillColor: Colors.white,
                                    filled: true
                                    ),
                                  ),
                                )
                              ),
                              Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                               Center(
                      child:SizedBox(
                        height: 40,
                        width: 300,
                        child:ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(170, 0, 0, 0)),
                        ),
                        onPressed: _handleLogin, // 绑定处理函数
                        child: Text('登录',style: TextStyle(color: Colors.white),),
                      ),
                      )
                    ),



                    Center(
                    child: Padding(
                     padding: const EdgeInsets.only(top: 12),
                    child: RichText(
                    text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    children: [
                  const TextSpan(text: '还没注册账号？'),
                      TextSpan(
                      text: '点此注册',
                       style: const TextStyle(
                            color: Colors.blue,
                        decoration: TextDecoration.underline,
                       ),
                      recognizer: TapGestureRecognizer()
                           ..onTap = () {
                           Navigator.pushNamed(context, '/register');
                          },
                        ),
                      ],
                     ),
                      ),
                     ),
                    ),
                              //放置文本
                            ],
                          ),
                        ),


                        
                      ),
                      )
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
  Future<void> _handleLogin() async {
    // 1. 获取输入值
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    
    // 2. 前端验证
    if (username.isEmpty || password.isEmpty) {
      _showError('请输入用户名和密码');
      return;
    }
    
    // 3. 调用后端API
    try {
      final result = await AuthService.login(username, password);
      
      // 4. 处理后端响应
      if (result['success'] == true) {
        // 登录成功
        setState(() {
          AuthService.isLoggedIn();
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // 登录失败
        _showError(result['message']);
      }
    } catch (e) {
      // 网络错误
      _showError('网络连接失败: $e');
    }
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return '邮箱不能为空';
  }
  if (!value.contains('@')) {
    return '请输入有效的邮箱地址';
  }
  return null;
}
  
  @override
  void dispose() {
    // 清理控制器，防止内存泄漏
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}