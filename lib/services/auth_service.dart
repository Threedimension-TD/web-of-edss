import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:8080';

  static final http.Client _client = http.Client();

  static Future<Map<String,dynamic>> login(String username,String password) async{
    try {
      // 发送登录请求（表单格式，这是Spring Security默认期望的）
      var response = await _client.post(
        Uri.parse('$_baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': username,
          'password': password,
        },
      );
      
      print('登录响应状态: ${response.statusCode}');
      print('响应头: ${response.headers}');
      
      // 解析响应
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        // 登录成功，保存用户信息到本地存储
        await _saveUserInfo(data['data']);
        return {'success': true, 'message': '登录成功', 'user': data['data']};
      } else {
        return {'success': false, 'message': data['message'] ?? '登录失败'};
      }
    } catch (e) {
      print('登录请求异常: $e');
      return {'success': false, 'message': '网络错误: $e'};
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      var response = await _client.get(
        Uri.parse('$_baseUrl/api/auth/me'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return {'success': true, 'user': data['data']};
        }
      }
      // 未登录或会话过期
      return {'success': false, 'message': '用户未登录'};
    } catch (e) {
      return {'success': false, 'message': '网络错误: $e'};
    }
  }

  static Future<void> logout() async {
    try {
      await _client.post(Uri.parse('$_baseUrl/api/auth/logout'));
    } catch (e) {
      print('登出请求异常: $e');
    } finally {
      // 清除本地用户信息
      await _clearUserInfo();
    }
  }

  static Future<void> _saveUserInfo(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', json.encode(userInfo));
  }
  
  // 从本地存储获取用户信息
  static Future<Map<String, dynamic>?> getLocalUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user_info');
    if (userString != null) {
      return json.decode(userString);
    }
    return null;
  }
  
  // 清除本地用户信息
  static Future<void> _clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_info');
  }

  //以下为注册

  // 在 AuthService 类中添加注册方法
static Future<Map<String, dynamic>> register({
  required String username,
  required String email,
  required String password,
  required String confirmPassword,
  String? nickname,
}) async {
  try {
    print('开始注册: $username, $email');
    
    var response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'nickname': nickname ?? username, // 如果没有昵称，默认使用用户名
      }),
    );
    
    print('注册响应状态: ${response.statusCode}');
    print('注册响应体: ${response.body}');
    
    final data = json.decode(response.body);
    
    if (response.statusCode == 200 && data['success'] == true) {
      // 注册成功，可以选择自动登录或直接返回成功
      return {'success': true, 'message': '注册成功', 'data': data['data']};
    } else {
      // 注册失败
      return {'success': false, 'message': data['message'] ?? '注册失败'};
    }
  } catch (e) {
    print('注册请求异常: $e');
    return {'success': false, 'message': '网络错误: $e'};
  }
}
}