import 'package:flutter/material.dart';
import 'package:web_of_edss/services/wiki_service.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _pageIdController = TextEditingController();

  // 创建页面并跳转
  void _createPage() async {
    final pageId = _pageIdController.text.trim();
    if (pageId.isEmpty) {
      // 如果 pageId 为空，则不继续执行
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('页面名称不能为空')),
      );
      return;
    }

    // 调用后端 API 创建页面
    try {
      await WikiService.createPage(pageId);  // 调用我们刚才创建的服务方法
      
      await Navigator.pushReplacementNamed(context, '/wiki/$pageId',);
// 自动配置路由，跳转到新页面
    } catch (e) {
      // 处理错误
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('创建页面失败，请重试')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
    child: SizedBox(
      width: 420,
      height: 260,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "创建新页面",
                style: TextStyle(
                  fontSize: 32,
                  color: Color.fromARGB(170, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                child: TextField(
                  
                  controller: _pageIdController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(170, 0, 0, 0), width: 2.0), // 设置选中时的边框颜色
              ),
                    isDense: true,
                    labelText: '输入页面名称',labelStyle: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _createPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(170, 0, 0, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: const Text("创建页面",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    ),
  );
    
  }
}
