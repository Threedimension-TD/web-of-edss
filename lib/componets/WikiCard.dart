import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;

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
  
  WikiMode _mode = WikiMode.view;

  Color _currentColor = Color.fromARGB(170, 0, 0, 0); // 初始化颜色为黑色
  double _currentFontSize = 16;
  String _loadedContent = '';  // 用来显示加载的内容

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
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
            onPressed: () => setState(() => _mode = WikiMode.edit),
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
              hintText: "支持 Markdown + HTML span 样式",
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
        "*": Style(  // 确保所有标签使用相同字体大小
          fontSize: FontSize(_currentFontSize),
        ),
      },
    );
  }

  // =========================
  // Toolbar
  // =========================
  Widget _buildEditorToolbar() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _toolBtn("B", () => _wrap("**", "**")),
        _toolBtn("I", () => _wrap("*", "*")),
        IconButton(
          tooltip: "文字颜色",
          icon: const Icon(Icons.color_lens),
          onPressed: _openColorPicker,
        ),
        _fontSizeDropdown(),

        IconButton(
          tooltip: "插入分割线",
          icon: const Icon(Icons.horizontal_rule),
          onPressed: _insertDivider,
        ),

        IconButton(
          tooltip: "清除样式",
          icon: const Icon(Icons.format_clear),
          onPressed: _removeSpan,
        ),
      ],
    );
  }

  Widget _toolBtn(String text, VoidCallback onTap) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _fontSizeDropdown() {
    const sizes = [12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52];

    return DropdownButton<double>(
      value: _currentFontSize,
      underline: const SizedBox(),
      items: sizes
          .map(
            (s) => DropdownMenuItem(
              value: s.toDouble(),
              child: Text("${s}px"),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v == null) return;
        setState(() => _currentFontSize = v);
        _wrapSpan(fontSize: v);
      },
    );
  }

  // =========================
  // Actions
  // =========================
  void _wrap(String left, String right) {
    final sel = _controller.selection;
    if (!sel.isValid || sel.isCollapsed) return;

    final text = _controller.text;
    final selected = text.substring(sel.start, sel.end);

    _controller.text = text.replaceRange(
      sel.start,
      sel.end,
      "$left$selected$right",
    );
  }

  void _wrapSpan({String? color, double? fontSize}) {
    final styles = [
      if (color != null) "color:$color",
      if (fontSize != null) "font-size:${fontSize}px",
    ].join(";");

    _wrap('<span style="$styles">', '</span>');
  }

  void _removeSpan() {
    final sel = _controller.selection;
    if (!sel.isValid || sel.isCollapsed) return;

    final text = _controller.text;
    final selected = text.substring(sel.start, sel.end);

    final cleaned = selected
        .replaceAll(RegExp(r'<span[^>]*>'), '')
        .replaceAll('</span>', '');

    _controller.text =
        text.replaceRange(sel.start, sel.end, cleaned);
  }

  void _openColorPicker() {
    Color tempColor = _currentColor; 

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("选择文字颜色"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (c) {
              tempColor = c; 
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _currentColor = tempColor; 
              });
              _wrapSpan(color: _colorToHex(_currentColor));
              Navigator.pop(context);
            },
            child: const Text("确定"),
          ),
        ],
      ),
    );
  }

  String _colorToHex(Color c) {
    final color = c ?? Colors.black;
    return "#${color.value.toRadixString(16).substring(2)}";
  }

  void _insertDivider() {
    final text = _controller.text;
    final sel = _controller.selection;

    final insert = "\n---";

    if (!sel.isValid) {
      _controller.text += insert;
      return;
    }

    _controller.text = text.replaceRange(
      sel.start,
      sel.start,
      insert,
    );

    // 光标移动到分割线后
    final pos = sel.start + insert.length;
    _controller.selection = TextSelection.collapsed(offset: pos);
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
        setState(() {
          _loadedContent = response.body;  // 加载返回的 HTML 内容
        });
      } else {
        throw Exception('文件加载失败：${response.statusCode}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }
}
