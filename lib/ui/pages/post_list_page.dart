import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/post_list_page/post_list_page_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/ui/widgets/post_widget.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostListPageBloc>(
      create: (_) => PostListPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("HTD PoC"),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: BlocBuilder<PostListPageBloc, PostListPageState>(
            builder: (BuildContext context, PostListPageState state) {
              return Column(
                children: [
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.loadedPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Post post = state.loadedPosts[index];
                        return PostWidget(post: post);
                      }),
                  ListTile(
                    title: RaisedButton(
                      onPressed: () {
                        context
                            .bloc<PostListPageBloc>()
                            .add(PostListPageEvent.tryLoadNextPage());
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
