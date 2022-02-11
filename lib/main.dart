import 'package:flutter/material.dart';
import 'package:geeclass/ui/theme/app_color.dart';
import 'package:geeclass/ui/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geeclass',
      theme: ThemeData(
        canvasColor: AppColor.black,
        fontFamily: "Inter",
      ),
      home: const HomeView(),
    );
  }
}
