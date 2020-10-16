import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:htd_poc/ui/pages/details_page.dart';

class ListElement extends StatelessWidget {
  final String title;

  const ListElement({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => DetailsPage()),
      ),
      title: Text(title),
    );
  }
}
