import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/list_page_bloc.dart';
import 'package:htd_poc/model/list_element_model.dart';
import 'package:htd_poc/ui/widgets/list_element.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListPageBloc>(
      create: (_) => ListPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("HTD PoC"),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: BlocBuilder<ListPageBloc, ListPageState>(
            builder: (BuildContext context, ListPageState state) {
              return Column(
                children: [
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.loadedElements.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ListElementModel elementModel =
                            state.loadedElements[index];
                        return ListElement(model: elementModel);
                      }),
                  ListTile(
                    title: RaisedButton(
                      onPressed: () {
                        context
                            .bloc<ListPageBloc>()
                            .add(ListPageEvent.tryLoadNextPage());
                      },
                      child: Text("Load more..."),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
