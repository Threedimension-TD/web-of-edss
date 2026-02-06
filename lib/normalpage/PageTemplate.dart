import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart'; // 你的底部导航栏组件

class PageTemplate extends StatelessWidget {
  final Widget bodyContent; // 页面中的主要内容
  final String backgroundImage; // 背景图路径
  final double cardWidth; // Card的宽度
  final TextEditingController _controller = TextEditingController();

  
  PageTemplate({
    Key? key,
    required this.bodyContent,
    this.backgroundImage = "assets/images/background.png", // 默认背景
    this.cardWidth = 2000, // 默认设置 Card 的宽度为 350
  }) : super(key: key);


void _createNewPage(BuildContext context) {
    String pageId = _controller.text.trim(); // 获取输入的 pageId
    if (pageId.isNotEmpty) {
      Navigator.pushNamed(context, '/page/$pageId');  // 跳转到动态生成的路由
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
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
                    // 包含 Card 的内容，直接在这里使用 Card
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(100), // 适当的 padding
                        child: Container(
                          
                          width: cardWidth, // 固定宽度
                          child: bodyContent
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: MyBottomBavigationBar(), // 你的底部导航栏
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
