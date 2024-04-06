import 'package:blog_app/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: const Text(
        'First Text\nnext text',
        style: TextStyle(
          fontSize: 16,
          height: .8,
        ),
      ),
    );
  }
}
