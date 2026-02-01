import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web_of_edss/MenuItem.dart';
import 'package:web_of_edss/services/auth_service.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  const MyAppBar({super.key});

  

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {






  Future<void> logoutAndGoHome(BuildContext context) async {
  await AuthService.logout();

  if (!context.mounted) return;

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/home',
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
        onTap: () => Navigator.pushNamed(context, '/home'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 30),
            Image.asset(
              'assets/images/logo.png',
              height: 80,
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
          
        /// 更新日志
        Tooltip(
          message: "更新日志",
          child: IconButton(
            iconSize: 30,
            icon: const Icon(Icons.update, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/update'),
          ),
        ),
        
        /// 更多菜单
        Tooltip(
          message: "更多页面",
          child: _buildMenuButton(context),
        ),
        const SizedBox(width: 20,)

        
      ],
    );
  }
//菜单
  Widget _buildMenuButton(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<MenuItem>(
        customButton: const Icon(Icons.menu, color: Colors.white,size: 30,),
        items: MenuItems.items
            .map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            )
            .toList(),
        onChanged: (item) {
          if (item != null) {
            Navigator.pushNamed(context, item.route);
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
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
                  title: const Text('退出登录'),
                  content: const Text('确定要退出当前账号吗？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('取消'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('退出'),
                    ),
                  ],
                ),
              );

              if (result == true) {
                await AuthService.logout();
                if (!context.mounted) return;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              }
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/images/Author.png'),
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
