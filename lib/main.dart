import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/themes/theme.dart';
import 'package:first_application/viewmodels/main_view_model.dart';
import 'package:first_application/views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: MaterialApp(
        theme: appTheme,
        home: MainScreen(),
      ),
    );
  }
}
