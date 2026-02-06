import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {
  static const String baseUrl = 'http://localhost:8080/api/wiki';  // 后端API的基础URL


static Future<List<String>> getAllPageIds() async {
  final url = Uri.parse('$baseUrl/pages');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<String>.from(jsonDecode(response.body));
  } else {
    throw Exception('加载页面列表失败');
  }
}
  // 创建页面
  static Future<void> createPage(String pageId) async {
    final url = Uri.parse('$baseUrl');

    // 创建请求体
    final body = jsonEncode({
      'pageId': pageId,
    });

    // 发送 POST 请求
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    // 检查响应状态
    if (response.statusCode != 201) {
      throw Exception('页面创建失败：${response.body}');
    }
  }

  // 获取页面内容
  static Future<String> getPageContent(String pageId) async {
    final url = Uri.parse('$baseUrl/$pageId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 如果请求成功，返回页面内容
      final data = jsonDecode(response.body);
      return data['content'] ?? '';
    } else {
      // 如果请求失败，抛出异常
      throw Exception('加载页面失败：${response.body}');
    }
  }
}
