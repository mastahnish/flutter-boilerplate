import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/ui/pages/user_page.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => UserPage(userId: post.userId)),
      ),
      title: Text(post.title),
    );
  }
}
