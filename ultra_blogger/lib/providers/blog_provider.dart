import 'package:flutter/material.dart';

class Blog {
  final String title;
  final String content;

  Blog(this.title, this.content);
}

class BlogProvider with ChangeNotifier {
  final List<Blog> _blogs = [];

  List<Blog> get blogs => List.unmodifiable(_blogs);

  void addBlog(String title, String content) {
    _blogs.add(Blog(title, content));
    notifyListeners();
  }
}
