import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';
import 'package:web_of_edss/componets/Widget.dart';
import 'package:web_of_edss/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _passwordVisible = false;

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
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(80),
                child: SizedBox(
                  width: 500,
                  height: 550,
                  child: Card(
                    color: Colors.white.withOpacity(0.75),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TitleText("注册"),

                          _buildInput(
                            controller: _usernameController,
                            label: "用户名",
                            icon: Icons.person,
                          ),

                          _buildInput(
                            controller: _emailController,
                            label: "邮箱",
                            icon: Icons.email,
                          ),

                          _buildInput(
                            controller: _passwordController,
                            label: "密码",
                            icon: Icons.lock,
                            obscure: !_passwordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),

                          _buildInput(
                            controller: _confirmPasswordController,
                            label: "确认密码",
                            icon: Icons.lock_outline,
                            obscure: true,
                          ),

                          SizedBox(height: 30),

                          SizedBox(
                            width: 300,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleRegister,
                              child: Text("注册",style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MyBottomBavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 300,
        height: 45,
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
  final username = _usernameController.text.trim();
  final email = _emailController.text.trim();
  final password = _passwordController.text;
  final confirmPassword = _confirmPasswordController.text;

  if (username.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    _showError("请填写完整注册信息");
    return;
  }

  if (!_isValidEmail(email)) {
    _showError("邮箱格式不正确");
    return;
  }

  if (password.length < 6) {
    _showError("密码长度至少 6 位");
    
  }

  if (password != confirmPassword) {
    _showError("两次输入的密码不一致");
    return;
  }

  setState(() => _isLoading = true);

  final result = await AuthService.register(
    username: username,
    email: email,
    password: password,
    confirmPassword: confirmPassword,
  );

  setState(() => _isLoading = false);

  if (result['success'] == true) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("注册成功，请登录")));
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    _showError(result['message']);
  }
}
bool _isValidEmail(String email) {
  final reg =
      RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  return reg.hasMatch(email);
}
void _showError(String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

}
