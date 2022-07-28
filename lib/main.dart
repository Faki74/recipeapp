import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/views/home.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Recipe',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
