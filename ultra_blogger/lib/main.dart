import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ultra_blogger/providers/blog_provider.dart';
import 'package:ultra_blogger/screens/blog_list_screen.dart';

void main() {
  runApp(const BloggingApp());
}

class BloggingApp extends StatelessWidget {
  const BloggingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogging App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const BlogListScreen(),
      ),
    );
  }
}
