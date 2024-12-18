import 'package:flutter/material.dart';

class SettingLabel extends StatelessWidget {
  final String title;

  SettingLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, // Использование цвета темы
        borderRadius: BorderRadius.circular(16), // Закругленные края
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
