import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class MinimalAvatarButton extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onAvatarPressed;
  final double size;
  
  const MinimalAvatarButton({
    super.key,
    this.onLoginPressed,
    this.onAvatarPressed,
    this.size = 40.0,
  });
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService.getLocalUserInfo(),
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.hasData && snapshot.data != null;
        final user = snapshot.data;
        
        return isLoggedIn 
            ? _buildAvatar(user!)
            : _buildLoginButton();
      },
    );
  }
  
  // 登录按钮（未登录状态）
  Widget _buildLoginButton() {
    return IconButton(
      icon: Icon(
        Icons.login,
        size: size * 0.6,
        color: Colors.white,
      ),
      onPressed: onLoginPressed,
      tooltip: '登录',
    );
  }
  
  // 用户头像（已登录状态）
  Widget _buildAvatar(Map<String, dynamic> user) {
    final username = user['username']?.toString() ?? 'User';
    final firstChar = _getFirstChar(username);
    final avatarColor = _generateColor(username);
    
    return GestureDetector(
      onTap: onAvatarPressed,
      child: Container(
        width: size,
        height: size,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: avatarColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            firstChar,
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  // 获取用户名的第一个字符
  String _getFirstChar(String username) {
    if (username.isEmpty) return '?';
    
    final trimmed = username.trim();
    final runes = trimmed.runes;
    
    if (runes.isEmpty) return '?';
    
    final firstChar = String.fromCharCode(runes.first);
    
    // 如果是英文字母，转换为大写
    if (firstChar.codeUnitAt(0) >= 97 && firstChar.codeUnitAt(0) <= 122) {
      return firstChar.toUpperCase();
    }
    
    return firstChar;
  }
  
  // 根据用户名生成一致的颜色
  Color _generateColor(String username) {
    if (username.isEmpty) return Colors.blue;
    
    int hash = 0;
    for (int i = 0; i < username.length; i++) {
      hash = username.codeUnitAt(i) + ((hash << 5) - hash);
    }
    
    final hue = (hash % 360).abs();
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.6).toColor();
  }
}