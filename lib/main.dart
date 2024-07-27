import 'package:flutter/material.dart';
import 'package:geeclass/ui/theme/app_color.dart'; // Ensure AppColor is defined
import 'package:geeclass/ui/views/home_view.dart'; // Ensure HomeView is defined

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
        canvasColor: AppColor.black, // Ensure AppColor.black is defined
        fontFamily: "Inter",
      ),
      home: const HomeView(), // Ensure HomeView is a valid Widget
    );
  }
}
