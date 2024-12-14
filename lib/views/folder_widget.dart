import 'package:flutter/material.dart';

class FolderWidget extends StatelessWidget{
  final String title;

  const FolderWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 350,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // Использование цвета темы
                borderRadius: BorderRadius.circular(16), // Закругленные края
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              )
            ),
          ),
        ),
      ),
    );
  }
}