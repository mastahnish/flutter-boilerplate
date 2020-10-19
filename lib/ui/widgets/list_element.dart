import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:htd_poc/model/list_element_model.dart';
import 'package:htd_poc/ui/pages/details_page.dart';

class ListElement extends StatelessWidget {
  final ListElementModel model;

  const ListElement({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => DetailsPage(
                  model: model,
                )),
      ),
      title: Text(model.name),
    );
  }
}
