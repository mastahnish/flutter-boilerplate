import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:htd_poc/model/list_element_model.dart';

class DetailsPage extends StatelessWidget {
  final ListElementModel model;

  const DetailsPage({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(),
    );
  }
}
