import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/bloc/post_list_page/post_list_page_bloc.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/ui/widgets/post_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 4.0).copyWith(top: 8.0),
          child: Builder(builder: (BuildContext context) {
            return _PostList(bloc: context.bloc<PostListPageBloc>());
          }),
        ),
      ),
    );
  }
}

class _PostList extends StatefulWidget {
  final PostListPageBloc bloc;

  const _PostList({Key key, @required this.bloc}) : super(key: key);

  @override
  __PostListState createState() => __PostListState();
}

class __PostListState extends State<_PostList> {
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(
      (_) => widget.bloc.add(PostListPageEvent.tryLoadNextPage()),
    );
    widget.bloc.listen((PostListPageState state) {
      _pagingController.itemList = state.loadedPosts;
      _pagingController.nextPageKey =
          state.canFetchMore ? _pagingController.nextPageKey + 1 : null;
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        itemBuilder: (BuildContext context, Post post, int index) {
          final Widget postWidget = PostWidget(post: post);
          return index < (_pagingController.itemList.length - 1)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: postWidget,
                )
              : postWidget;
        },
      ),
    );
  }
}
