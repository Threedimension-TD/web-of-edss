import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> _saveToServer(String content) async {
  final url = Uri.parse('https://your-server.com/api/save'); // 服务端保存路径

  // 将内容转换为 JSON
  final body = jsonEncode({
    'content': content,
  });

  try {
    // 发送 POST 请求
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // 请求头
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('文件已成功保存到服务端！');
    } else {
      print('保存失败：${response.statusCode}');
    }
  } catch (e) {
    print('请求错误: $e');
  }
}
