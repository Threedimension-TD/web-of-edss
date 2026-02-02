import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:web_of_edss/services/auth_service.dart';
import 'package:web_of_edss/specialpage/LoginPage.dart';

enum WikiMode { view, edit }

class WikiCard extends StatefulWidget {
  final String initialContent;
  final ValueChanged<String>? onSave;
  final double width;

  const WikiCard({
    super.key,
    required this.initialContent,
    this.onSave,
    this.width = 2000,
  });


  @override
  State<WikiCard> createState() => _WikiCardState();
}

class _WikiCardState extends State<WikiCard> {
  late TextEditingController _controller;
  bool isLoggedIn = false;  
  WikiMode _mode = WikiMode.view;

  Color _currentColor = Color.fromARGB(170, 0, 0, 0); // 初始化颜色为黑色
  double _currentFontSize = 24;
  String _loadedContent = '';  // 用来显示加载的内容

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _checkLoginStatus(); 
    _loadFromServer(); 
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        margin: const EdgeInsets.symmetric(vertical: 0),
        child: Card(
          color: Colors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const Divider(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _checkLoginStatus() async {
    bool loggedIn = await AuthService.isLoggedIn();  // 使用 AuthService 检查登录状态
    setState(() {
      isLoggedIn = loggedIn;  // 更新登录状态
    });
  }
  // =========================
  // Header
  // =========================
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          _mode == WikiMode.view ? "阅读模式" : "编辑模式",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        if (_mode == WikiMode.view)
          TextButton.icon(
            icon: const Icon(Icons.edit,color: Color.fromARGB(170, 0, 0, 0),),
            label: const Text("编辑",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),),
            onPressed: () { 
              if(isLoggedIn) {
              setState(() => _mode = WikiMode.edit);
              }else{
                
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
               },
          ),
        if (_mode == WikiMode.edit) ...[
          TextButton(
            onPressed: () => setState(() => _mode = WikiMode.view),
            child: const Text("取消",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              widget.onSave?.call(_controller.text);
              await _saveToServer(_controller.text); 
              setState(() => _mode = WikiMode.view);
            },
            child: const Text("保存",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(170, 0, 0, 0))
            ),
          ),
        ]
      ],
    );
  }

  // =========================
  // Body
  // =========================
  Widget _buildBody() {
    if (_mode == WikiMode.edit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditorToolbar(),
          const SizedBox(height: 5),
          TextField(
            controller: _controller,
            maxLines: null,
            style: TextStyle(fontSize: _currentFontSize), // 使用动态字体大小
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "支持HTML样式",
            ),
          ),
        ],
      );
    }

final html = md.markdownToHtml(_controller.text);

  // 确保 HTML 内容不为 null
  final htmlContent = html.isNotEmpty ? html : "<p>暂无内容</p>";
    
    return Html(
      data: htmlContent,
       // 直接显示加载的内容（包括 HTML 标签）
      style: {
        "body": Style(
          fontSize: FontSize(_currentFontSize),  // 渲染时应用字体大小
        ),
        "h1": Style(  // 确保所有标签使用相同字体大小
          fontSize: FontSize(52),
          fontWeight: FontWeight.normal
          
        ),
        "hr":Style(
          color: Colors.white
        ),
        "b": Style(
        fontWeight: FontWeight.bold,
        ),
        "i": Style(
          fontStyle: FontStyle.italic,
        ),
        
       
      },
      
    );
  }

  // =========================
  // Toolbar
  // =========================
  Widget _buildEditorToolbar() {
    return Text("请按照html格式编辑页面，例：<h1>新建页面</h1> 快捷标签：<b>加粗 <i>斜体 <u>下划线");
  }

  
  Future<void> _saveToServer(String content) async {
    final pageId = "MainPage";
    final url = Uri.parse('http://localhost:8080/api/save?pageId=$pageId'); // 服务端保存路径

    // 将内容转换为 JSON
    final body = jsonEncode({
      'content': content,
    });

    try {
      // 发送 POST 请求
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Host': 'localhost:8080',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('文件已成功保存到服务端！');
        _loadFromServer();  // 保存成功后立即加载
      } else {
        print('保存失败：${response.statusCode}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }

  Future<void> _loadFromServer() async {
    final String pageId = "MainPage";
    final url = Uri.parse('http://localhost:8080/api/load?pageId=$pageId'); // 服务端加载路径

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final String content = jsonResponse['content'] ?? ''; 
        setState(() {
          _controller.text = content;  // 加载返回的 HTML 内容
        });
      } else {
        throw Exception('文件加载失败：${response.statusCode}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }
}
