import 'package:flutter/material.dart';

class MenuItem {
  final String text;
  final IconData icon;
  final String route;

  const MenuItem({
    required this.text,
    required this.icon,
    required this.route,
  });
}

class MenuItems {
  static const List<MenuItem> items = [
    home,
    NotFound
  ];


  static const home = MenuItem(
    text: '首页',
    icon: Icons.home,
    route: '/home',
  );

  static const NotFound = MenuItem(
    text: '404',
    icon: Icons.more_horiz,
    route: '/none',
  );

  static Widget buildItem(MenuItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        children: [
          Icon(item.icon, color: Colors.white, size: 22),
          SizedBox(width: 12),
          Text(
            item.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );

  }
}