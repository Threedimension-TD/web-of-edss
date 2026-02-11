import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web_of_edss/componets/WikiCard.dart';
import 'package:web_of_edss/main.dart';
import 'package:web_of_edss/services/auth_service.dart';
import 'package:web_of_edss/services/wiki_service.dart';
import 'package:web_of_edss/specialpage/LoginPage.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  const MyAppBar({super.key});

  

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {

List<String> wikiPages = [];
  bool loadingWikiPages = true;
  bool isLoggedIn = false;

@override
  void initState() {
    super.initState();
    _loadWikiPages();
    _checkLoginStatus();
  }


void _checkLoginStatus() async {
    final loggedIn = await AuthService.isLoggedIn();
    setState(() => isLoggedIn = loggedIn);
  }

Future<void> _loadWikiPages() async {
    try {
      final pages = await WikiService.getAllPageIds();
      if (mounted) {
        setState(() {
          wikiPages = pages;
          loadingWikiPages = false;
        });
      }
    } catch (e) {
      loadingWikiPages = false;
    }
  }


  Future<void> logoutAndGoHome(BuildContext context) async {
  await AuthService.logout();

  if (!context.mounted) return;

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/',
    (route) => false,
  );
}




  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 80,

      
      /// 中间：Logo + 标题（响应式）
      title: InkWell(
        onTap: () => Navigator.pushNamed(context, '/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 30),
            Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
            const SizedBox(width: 5),
            SizedBox(
              height: 25,
              width: 120,
              child: Image.asset('assets/images/textlogo.png'),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                '永昼生存服务器',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      /// 右侧功能区（紧凑排列）
      actions: [
        /// 登录 / 头像



          _buildUserButton(context),
          Tooltip(
            message: "新建页面",
            child: IconButton(onPressed: 
            () {
              if (isLoggedIn) {
               Navigator.pushNamed(context, "/create");
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              }
            },//=> Navigator.pushNamed(context, "/create"), 
            icon: const Icon(Icons.add,color: Colors.white,)),
          ),
          
          
          
        /// 更新日志
        Tooltip(
          message: "更新日志",
          child: IconButton(
            iconSize: 30,
            icon: const Icon(Icons.update, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/update'),
          ),
        ),
        SizedBox(width: 8),
        
        _buildWikiMenu(context),
        /// 更多菜单
        
        
      ],
    );
  }
//菜单
  

  Widget _buildWikiMenu(BuildContext context) {
  if (loadingWikiPages) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  return Padding(padding: EdgeInsets.only(right: 10),
  child: DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      customButton: const Tooltip(
        message: "Wiki 页面",
        child: Icon(
          Icons.menu,
          color: Colors.white,
          size: 28,
        ),
      ),
      items: wikiPages.map((pageId) {
        return DropdownMenuItem<String>(
          value: pageId,
          child: GestureDetector(
            onDoubleTapDown: (details){
              if (!isLoggedIn) return;

        _showDeleteMenu(
          context,
          pageId,
          details.globalPosition,
        );
        
            },
            child: Text(
            pageId,
            style: const TextStyle(color: Colors.white),
          ),
          )
        );
      }).toList(),
      onChanged: (pageId) {
        if (pageId != null) {
          Navigator.pushNamed(context, '/wiki/$pageId');
        }
      },
      dropdownStyleData: DropdownStyleData(
        width: 220,
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 40, 40, 40),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  )
  );
}

void _showDeleteMenu(
  BuildContext context,
  String pageId,
  Offset position,
) async {
  final result = await showMenu<String>(
    context: context,
    color: Color.fromARGB(200, 40, 40, 40),//.withOpacity(0.7),
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    items: [
      const PopupMenuItem(
        
        value: 'delete',
        
        child: Row(
          
    children: const [
      Icon(
        Icons.delete,
        color: Colors.red,
        size: 18,
      ),
      SizedBox(width: 8),
      Text(
        '删除页面',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  ),
      ),
    ],
  );

  if (result == 'delete') {
    _confirmDeletePage(context, pageId);
  }
}

void _confirmDeletePage(BuildContext context, String pageId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
      title: const Text('确认删除'),
      content: Text('确定要删除页面「$pageId」吗？此操作不可恢复。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消',style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);

            try {
              await WikiService.deletePage(pageId);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('页面已删除')),
              );

              // 重新加载页面列表
              await _loadWikiPages();

            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('删除失败：$e')),
              );
              
            }
          },
          child: const Text(
            '删除',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}

//登录按钮
  Widget _buildUserButton(BuildContext context) {
  return FutureBuilder<bool>(
    future: AuthService.isLoggedIn(),
    builder: (context, snapshot) {
      final loggedIn = snapshot.data == true;

      if (loggedIn) {
        //已登录：头像（可点击）
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
                  title: const Text('退出登录'),
                  content: const Text('确定要退出当前账号吗？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('取消',style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('退出',style: TextStyle(color: Color.fromARGB(199, 255, 0, 0)),),
                    ),
                  ],
                ),
              );

              if (result == true) {
                await AuthService.logout();
                if (!context.mounted) return;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              }
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/images/logged.png'),
            ),
          ),
        );
      } else {
       //未登录：登录按钮
        return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text(
            '登录',
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    },
  );
}

}
