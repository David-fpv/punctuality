import 'package:flutter/material.dart';

class StatisticalWidget extends StatelessWidget {
  final String title;
  final String rating;

  const StatisticalWidget({
    Key? key,
    required this.title,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Использование цвета темы
            borderRadius: BorderRadius.circular(16), // Закругленные края
          ),
          child: Center(
            child: Text(
              rating,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 275,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Использование цвета темы
            borderRadius: BorderRadius.circular(16), // Закругленные края
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
