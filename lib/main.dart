import 'package:flutter/material.dart';
import 'package:htd_poc/ui/pages/list_page.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTD PoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListPage(),
    );
  }
}
