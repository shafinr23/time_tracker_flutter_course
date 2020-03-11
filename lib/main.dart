import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'time tracker',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
