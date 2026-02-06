import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:web_of_edss/services/auth_service.dart';
import 'package:web_of_edss/specialpage/LoginPage.dart';

enum WikiMode { view, edit }

class WikiCard extends StatefulWidget {
  final String? pageId;
  final double width;

  const WikiCard({
    super.key,
    required this.pageId,
    this.width = 2000,
  });

  @override
  State<WikiCard> createState() => _WikiCardState();
}

class _WikiCardState extends State<WikiCard> {
  late TextEditingController _controller;
  WikiMode _mode = WikiMode.view;
  bool isLoggedIn = false;

  double _currentFontSize = 24;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _checkLoginStatus();
    _loadFromServer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // =========================
  // 登录状态
  // =========================
  void _checkLoginStatus() async {
    final loggedIn = await AuthService.isLoggedIn();
    setState(() => isLoggedIn = loggedIn);
  }

  // =========================
  // UI
  // =========================
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

        /// 编辑
        if (_mode == WikiMode.view)
          TextButton.icon(
            icon: const Icon(Icons.edit, color: Color.fromARGB(170, 0, 0, 0)),
            label: const Text("编辑", style: TextStyle(color: Color.fromARGB(170, 0, 0, 0))),
            onPressed: () {
              if (isLoggedIn) {
                setState(() => _mode = WikiMode.edit);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              }
            },
          ),

        /// 编辑模式按钮
        if (_mode == WikiMode.edit) ...[
          TextButton(
            onPressed: () => setState(() => _mode = WikiMode.view),
            child: const Text("取消",style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(170, 0, 0, 0)),
            ),
            onPressed: () async {
              await _saveToServer(_controller.text);
              setState(() => _mode = WikiMode.view);
            },
            child: const Text("保存",style: TextStyle(color: Colors.white),),
          ),
        ],
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
          const SizedBox(height: 8),
          TextField(

            controller: _controller,
            maxLines: null,
            style: TextStyle(fontSize: _currentFontSize),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(170, 0, 0, 0), width: 2.0), // 设置选中时的边框颜色
              ),
              border: OutlineInputBorder(),
              hintText: "支持HTML",
            ),
          ),
        ],
      );
    }

    /// 阅读模式
    final html = md.markdownToHtml(_controller.text);
    final htmlContent = html.isNotEmpty ? html : "<p>暂无内容</p>";

    return Html(
      data: htmlContent,
      style: {
        "body": Style(fontSize: FontSize(_currentFontSize)),
        "h1": Style(fontSize: FontSize(48)),
        "h2": Style(fontSize: FontSize(36)),
        "b": Style(fontWeight: FontWeight.bold),
        "i": Style(fontStyle: FontStyle.italic),
        "hr": Style(color: Colors.grey),
      },
    );
  }

  // =========================
  // Toolbar
  // =========================
  Widget _buildEditorToolbar() {
    return const Text(
      "使用html进行编辑，示例：<h1>Page Content</h1>",
      style: TextStyle(color: Colors.black54),
    );
  }

  // =========================
  // API
  // =========================
  Future<void> _saveToServer(String content) async {
    final url = Uri.parse(
      'http://localhost:8080/api/wiki/${widget.pageId}',
    );

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'content': content}),
      );

      if (response.statusCode != 200) {
        debugPrint('保存失败：${response.statusCode}');
      }
    } catch (e) {
      debugPrint('保存异常: $e');
    }
  }

  Future<void> _loadFromServer() async {
    final url = Uri.parse(
      'http://localhost:8080/api/wiki/${widget.pageId}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _controller.text = data['content'] ?? '';
        });
      }
    } catch (e) {
      debugPrint('加载异常: $e');
    }
  }
}
